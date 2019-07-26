## Resubmission
This is a resubmission. In this version I have:

* Replaced \dontrun with \donttest. The \donttest option is used
  in order to meet CRAN policies requirements regarding the use
  of Internet resources (\donttest will not result with a check warning
  nor error when Internet is missing). When no connection is present
  the functions will return an error informing the user that there
  is no Internet connection. 
* Provided a more elaborate description of the package
* Removed the redundant "R" from the title
* Removed the unnecessary LICENSE file and its reference in the
  DESCRIPTION file

## Test environments
* local ubuntu 18.04 install, R 3.5.3
* ubuntu 14.04 (on travis-ci), R 3.5.3
* win-builder (devel and release)
* AppVeyor, R 3.6.1

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
