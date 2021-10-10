###############################################################################
# Joshua C. Fjelstul, Ph.D.
# downloadr R package
###############################################################################

##################################################
# download search results
##################################################

# filter
data <- dplyr::tibble(
  url = c(
    "https://en.wikipedia.org/wiki/European_Council",
    "https://en.wikipedia.org/wiki/Council_of_the_European_Union",
    "https://en.wikipedia.org/wiki/European_Parliament",
    "https://en.wikipedia.org/wiki/European_Commission",
    "https://en.wikipedia.org/wiki/Court_of_Justice_of_the_European_Union"
  ),
  file = c(
    "european-council.html",
    "council-of-the-european-union.html",
    "european-parliament.html",
    "european-commission.html",
    "court-of-justice-of-the-european-union.html"
  )
)

# download
download_files(
  urls = data$url,
  files = data$file,
  delay_min = 3,
  delay_max = 5,
  folder_path = "example/downloaded-files/"
)

###############################################################################
# end R script
###############################################################################
