
/* Briana Kuo (brkuo) and Liam Shaw (lmshaw)
   CSC 453 Program 2 | Fall 2022 | Foaad Khosmood */

#include <stdio.h>
#include <stdlib.h>
#include "lwp.h"
#include "rr.h"

thread curr = NULL;
thread root = NULL;
tid_t thread_id = 1;
rfile original_stack;
unsigned long original_sp;

/* useful for "intuitively" building stacks */
#define push(sp,val) (*(--sp)=(unsigned long)(val))


static unsigned long *new_intel_stack64(unsigned long *sp,lwpfun func){
   /* mock up a stack for the INTEL architecture
   * First, a frame that returns to lwp_exit() should our function actually
   * return.
   */

   unsigned long *ebp;

   push(sp,lwp_exit);        /* just in case this lwp tries to return */
   push(sp,func);            /* push the function's return address */
   push(sp,0);               /* push a "saved" base pointer */

   ebp=sp;                   /* note the location for use later... */

   return ebp;
}


/* create: creates a new lwp which executes the given function with the given
 * argument. returns the thread id of the lwp. */
tid_t lwp_create(lwpfun function, void * argument, size_t stacksize) {
   unsigned long * stackPointer;
   thread temp = malloc(sizeof(context));

   temp->stack = malloc(stacksize * sizeof(unsigned long));
   temp->stack += stacksize;
   temp->stacksize = stacksize;

   stackPointer = temp->stack;

   temp->state.rbp = (unsigned long)new_intel_stack64(stackPointer, function);
   temp->state.rsp = (unsigned long)stackPointer;
   temp->state.rdi = (unsigned long)argument;

   temp->state.fxsave = FPU_INIT;

   if(root == NULL){
      root = temp;
   }
   else{
      curr->lib_one = temp;
      temp->lib_two = curr;
   }

   curr = temp;
   RoundRobin->admit(temp);

   temp->tid = thread_id++;
   return temp->tid;
}


/* exit: terminates the current lwp, frees its resources, and gets the next
 * thread. if there are no other threads, restores original system thread. */
void lwp_exit(void) {
   RoundRobin->remove(curr);
   free(curr->stack - curr->stacksize);
   free(curr);
   curr = RoundRobin->next();
   if(!curr){
      load_context(&original_stack);
      return;
   }
   load_context(&(curr->state));
}


/* gettid: returns tid of the calling lwp or NO_THREAD if not called by lwp */
tid_t lwp_gettid(void) {
   return curr ? curr->tid : NO_THREAD;
}

/* yield: yields control to lwp indicated by scheduler. saves current lwp's 
 * context, restores new thread's context, and returns */
void lwp_yield(void) {
   save_context(&(curr->state));
   curr = RoundRobin->next();
   if(!curr){
      load_context(&original_stack);
      return;
   }
   load_context(&(curr->state));
}


/* start: starts lwp system. saves original context, picks a lwp and starts it.
 * if there are no lwps, returns immediately. */
void lwp_start(void) {
   if(!root){
      return;
   }
   save_context(&original_stack);
   GetSP(original_sp);

   curr = RoundRobin->next();
   if(!curr){
      load_context(&original_stack);
      return;
   }
   load_context(&(curr->state));
}


/* stop: stops lwp system, restores original sp and returns to that context.
 * wherever lwp_start() was called from, lwp_stop() does not destroy any
 * existing contexts, and thread processing will be restarted by a call to
 * lwp_start(). */
void lwp_stop(void) {
   save_context(&(curr->state));
   SetSP(original_sp);
   load_context(&original_stack);
}



/* set_scheduler: lwp package uses given scheduler to choose the next proces
 *  to run. transfers all threads from the old scheduler to the new one in
 *  next() order. if scheduler is NULL the library returns to rr scheduling. */
void lwp_set_scheduler(scheduler fun) {
   if (!fun){
      return;
   }
   curr = root;
   RoundRobin = fun;
   while (curr){
      fun->admit(curr);
      curr = curr->lib_one;
   }
   return;
}


/* get_scheduler: returns pointer to the current scheduler */
scheduler lwp_get_scheduler(void) {
   return RoundRobin;
}


/* tid2thread: returns the thread corresponding to given tid, or NULL if id is
 * invalid. */
thread tid2thread(tid_t tid) {
   curr = root;
   while (curr) {
      if (curr->tid == tid) {
         return curr;
      }
      curr = curr->lib_one;
   }
   return NULL;
}

