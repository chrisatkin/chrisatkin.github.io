---
title: Research - Locomotion
layout: main
---
![Locomotion](assets/locomotion.png)

# The Locomotion Project

The Locomotion Project developed a profiler which detects candidate loops for parallelization dynamically at runtime with minimal overhead (in both time and space). I used the [Graal compiler infrastructure](http://openjdk.java.net/projects/graal) in order to identify loops and perform analysis within those loops to proove the existance of memory dependencies.

The overhead of this analysis was shown to be minimal in both time and space, with additional memory requirements within the 10s of MB range and adding roughly 5% to runtime in compute-intensive applications.

Locomotion made up my [Masters thesis](cv.html) and was supervised by [Dr. Christophe Dubach](http://homepages.inf.ed.ac.uk/cdubach) and [Dr. Bjoern Franke](http://homepages.inf.ed.ac.uk/bfranke). A copy of the [PDF](pub/parallelism-detection.pdf) is available.

## Source code

The Locomotion source code is available on [GitHub](https://github.com/chrisatkin/locomotion). You will also need a copy of Graal in your classpath. **Note: Locomotion is a research project and not production-ready.**

[![GitHub](assets/github-logo.png)](https://github.com/chrisatkin/locomotion)

## License

Locomotion is licensed under the [CRAPL](http://matt.might.net/articles/crapl/).

<hr>


[![University of Edinburgh](assets/ed.png)](http://www.inf.ed.ac.uk)