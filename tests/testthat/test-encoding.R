context("test-encoding.R")

test_that("code handle accents", {
  expect_equal( code("cr\u00e8me br\u00fbl\u00e9e"), "crme brle-13ar8s")
})

test_that("code handle emojis", {
  txt <- "hello\U0001F4A9"

  expect_equal( code(txt), "hello-bf14d" )
})
