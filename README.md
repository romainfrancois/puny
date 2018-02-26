
<!-- README.md is generated from README.Rmd. Please edit that file -->
puny
====

[![Travis build status](https://travis-ci.org/romainfrancois/puny.svg?branch=master)](https://travis-ci.org/romainfrancois/puny) [![Coverage status](https://codecov.io/gh/romainfrancois/puny/branch/master/graph/badge.svg)](https://codecov.io/github/romainfrancois/puny?branch=master)

`puny` is an encoder/decoder for the [punycode](https://en.wikipedia.org/wiki/Punycode) format

Installation
------------

You can install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("romainfrancois/puny")
```

Encoding in punycode
--------------------

``` r
# dessert
puny::code( "crème brûlée" )
#> [1] "crme brle-13ar8s"

# emojis with the from `emo` 
( s <- emo::ji_glue("emoji :poop: also work") )
#> emoji 💩 also work
puny::code( s )
#> [1] "emoji  also work-s509o"
```

Code of Conduct
---------------

Please note that this project is released with a [Contributor Code of Conduct](.github/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
