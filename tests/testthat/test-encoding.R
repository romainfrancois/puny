context("test-encoding.R")

test_that("code does not harm ascii strings", {
  expect_equal( code("yada"), "yada")
})

test_that("code handle accents", {
  yummy <- "cr\u00e8me br\u00fbl\u00e9e"

  expect_equal( code(yummy), "crme brle-13ar8s")
})

test_that("code handle emojis", {
  txt <- "hello\U0001F4A9"

  expect_equal( code(txt), "hello-bf14d" )
})
