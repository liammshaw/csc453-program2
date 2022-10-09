
/* Briana Kuo (brkuo) and Liam Shaw (lmshaw)
   CSC 453 Program 2 | Fall 2022 | Foaad Khosmood */

#include <stdio.h>
#include <stdlib.h>
#include "lwp.h"


/* create: creates a new lightweight process which executes the given
 * function with the given argument. the new processes's stack will be
 * stacksize words. */
tid_t (lwpfun function, void * argument, size_t stacksize) {
}


/* exit: terminates the current lwp and frees its resources. calls
 * sched->next to get the next thread. if there are no other threads, restores
 * the original system thread. */
void lwp_exit(void) {
}


/* gettid: returns tid of the calling lwp or NO_THREAD if not called by lwp */
tid_t lwp_gettid(void) {
}


/* yield: yields control to another lwp (which one depends on scheduler). saves
 * current lwp's context, picks the next one, restores that thread's context,
 * and returns */
void lwp_yield(void) {
}


/* start: starts lwp system. saves original context (for lwp_stop() to use
 * later), picks a lwp and starts it running. if there are no lwps, returns
 * immediately. */
void lwp_start(void) {
}


/* stop: stops lwp system, restores original sp and returns to that context.
 * wherever lwp_start() was called from, lwp_stop() does not destroy any
 * existing contexts, and thread processing will be restarted by a call to
 * lwp_start(). */
void lwp_stop(void) {
}



/* set_scheduler: causes the lwp package to use given scheduler to choose the
 * next process to run. transfers all threads from the old scheduler to the
 * new one in next() order. if scheduler is NULL the library should return to
 * rr scheduling. */
void lwp_set_scheduler(scheduler fun);


/* get_scheduler: returns pointer to the current scheduler */
scheduler lwp_get_scheduler(void);


/* tid2thread: returns the thread corresponding to given tid, or NULL if id is
 * invalid. */
thread tid2thread(tid_t tid);

