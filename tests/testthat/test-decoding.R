context("test-decoding.R")

test_that( "decode handles accents", {
  expect_equal( decode("tda"), "\u00fc" )
  expect_equal( decode("bcher-kva"), "b\u00fccher")
} )

test_that( "decode handles emojis", {
  expect_equal( decode("hello-bf14d"), "hello\U0001F4A9" )
} )
