---
title: Research - Locomotion
layout: main
---
![Locomotion](assets/locomotion.png)
# The Locomotion Project
The Locomotion Project developed a profiler which detects parallel loops dynamically at runtime. This profiler uses the [Graal compiler infrastructure](http://openjdk.java.net/projects/graal/) in order to register every read and write operation to/from memory and identify potential dependancies. Storing this dependency metadata is memory-intensive, so the use of Bloom filters was investigated.

It was concluded that dynamic parallelism detection is indeed possible, and with minimal overhead (in terms of both execution time and memory usage).

Locomotion made up my [Masters thesis](cv.html) and was supervised by [Dr. Christophe Dubach](http://homepages.inf.ed.ac.uk/cdubach) and [Dr. Bjoern Franke](http://homepages.inf.ed.ac.uk/bfranke). A copy of the [PDF](pub/parallelism-detection.pdf) is available.

## Source code

The Locomotion source code is available on [GitHub](https://github.com/chrisatkin/locomotion). You will also need a copy of Graal in your classpath. **Note: Locomotion is a research project and not production-ready.**

[![GitHub](assets/github-logo.png)](https://github.com/chrisatkin/locomotion)

## License

Locomotion is licensed under the [CRAPL](http://matt.might.net/articles/crapl/).

<hr>


[![University of Edinburgh](assets/ed.png)](http://www.inf.ed.ac.uk)