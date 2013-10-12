---
course: Foundations of Parallel Algorithmics, Languages and Systems
title: Welcome
layout: course
---

# Welcome

![UReddit](assets/ureddit.png)

Welcome to the course page for _Foundations of Parallel Algorithmics, Languages and Systems_ at the [University of Reddit](http://ureddit.com).

## What is this course about?
This course is a **Computer Science** course aimed at teaching the fundamental principals of designing and implementing parallel algorithms.

## Why should I take it?
Because parallel algorithms and systems are becoming all pervasive in real-world scenarios. It isn't enough to have theoretical knowledge anymore, many real-world systems are already highly parallel.

Another reason is that parallel systems are difficult and present some new and exciting challenges. Parallelism is an excellent area in CS to walk the line between deep theoretical knowledge with real-world impact.

## Curriculum

### Schedule 1: Theoretical Foundations
This section will mainly serve as an introduction to theoretical parallel algorithmics. Although many of the constructs and models we'll use in this schedule are too abstract to directly translate into real-world code, it teaches one how to think in a parallel way.

 - Refresher of big-o notation and asymptotic analysis
 - Parallel time analysis, cost optimality, Brent's theorem, Amdahl's law
 - Abstract models (shared memory and message passing) and architectures (grid, mesh, n-dimensional hypercubes)
 - Communication
 - Parallel algorithms: sorting, matrix multiplication etc
 
### Schedule 2: Architectures
Parallelism (at least in it's current form) is deeply rooted in computer hardware. As of right now, there aren't really any high-level abstractions for parallelism that have taken root, so we're stuck with low-level 'nitty-gritty' stuff.

 - Types of Parallelism
 - Uniprocessors (pipelining, superscalars)
 - Multiprocessors and cache coherence
 - Synchronisation
 - Multithreading and multicores
 - Vector and SIMD processors
 
### Schedule 3: Languages
At this stage we'll move on to actually implementing parallel algorithms using the systems programming language of your choice.

 - Issues in real-world programming: mutual exclusion, condition synchronisation, locks, barriers, semaphores, channels, collectives
 - Shared memory programming with OpenMPI and pthreads
 - Message passing with OpenMP
 - Hybrid models and abstractions: Tread Building Blocks, tuple space

## Exercises and Assessments
There will be between two and three exercises provided for each schedule which will test your knowledge and understanding of the issues covered. They will range from the theoretical (pencil-and-paper style) to the practical (involving programming real algorithms).

I can also offer a 'final' exam if it's desired by people.

## Requirements
This is a honours or graduate level class and assumes you are already familiar with:

 - **Mathematics**: Big-O notation, asymptotic analysis, logarithms
 - **Computer Science**: the more you know about algorithms, the better. I'm going to assume you have some experience of designing and analysing algorithms. You should know (or can look up and understand) quicksort and mergesort, I'll use those as examples. An undergraduate-level understanding of computer systems and architectures would be extremely helpful as well.
 - **Programming**: you need to know at least one systems programming language. I'm going to be using C, but Fortran would work as well. I think C++ would also work as well (for OpenMP), but I haven't tried this myself. If the language supports OpenMP and OpenMPI it's fine. Java would also be helpful.
 - **Hardware**: I'll assume you have access to a Unix (or compatible) machine - think Linux, BSD, OS X etc. I'm sure that you could use Windows as well, but I haven't tried it myself.
 
It'd definitely possible to pick some of these up as you go along, but more than one or two things and I'd say that you should probably try another course first.