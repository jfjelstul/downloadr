###############################################################################
# Joshua C. Fjelstul, Ph.D.
# downloadr R package
###############################################################################

download_files <- function(urls, files, delay_min = 3, delay_max = 5, folder_path = "", method = "auto", mode = "w") {

  # validate "urls"
  if(class(urls) != "character") {
    stop("the 'urls' argument should be a chracter vector with the same length as 'files'")
  }

  # validate "files"
  if(class(files) != "character") {
    stop("the 'files' argument should be a chracter vector with the same length as 'url'")
  }

  # validate "delay_min" and "delay_max"
  if(class(delay_min) != "numeric" | length(delay_min) != 1 | delay_min < 0) {
    stop("the 'delay_min' argument should be a number")
  }
  if(class(delay_max) != "numeric" | length(delay_max) != 1 | delay_max < delay_min) {
    stop("the 'delay_max' argument should be a number greater than 'delay_min'")
  }

  # validate "folder_path"
  if(class(folder_path) != "character" | length(folder_path) != 1) {
    stop("the 'folder_path' argument should be a string")
  }

  # clean folder path
  folder_path <- stringr::str_remove(folder_path, "/$")
  folder_path <- stringr::str_replace(folder_path, "$", "/")

  # clean file names
  files <- stringr::str_remove(files, "^/")

  # data
  data <- dplyr::tibble(url = urls, file = files)

  # the number of documents requested
  n_documents <- length(urls)

  # list files in folder
  downloaded <- list.files(folder_path)
  downloaded <- downloaded[downloaded %in% files]

  # the number of documents already downloaded
  n_downloaded <- length(downloaded)

  # drop documents that have already been downloaded
  if (n_downloaded > 0) {
    data <- dplyr::filter(data, !(file %in% downloaded))
  }

  # check if all files have already been downloaded
  if (nrow(data) == 0) {

    # message
    cat("\nAll files have already been downloaded!")

  } else {

    # message
    message <- stringr::str_c("\rDone: ", n_downloaded, " of ", n_documents, " files already downloaded.\n")
    message <- stringr::str_pad(message, side = "right", pad = " ", width = 100)
    cat(message)

    # the number of documents not already downloaded
    n_to_download <- nrow(data)

    # message
    message <- stringr::str_c("\rTo do: ", n_to_download, ifelse(n_to_download > 1, " files", " file"), " to download.\n")
    message <- stringr::str_pad(message, side = "right", pad = " ", width = 100)
    cat(message)

    # loop through pages
    for(i in 1:n_to_download) {

      # message
      message <- stringr::str_c("\rDownloading file ", i, " of ", n_to_download, "...")
      message <- stringr::str_pad(message, side = "right", pad = " ", width = 100)
      cat(message)

      # download the HTML page
      try(suppressWarnings(download.file(data$url[i], stringr::str_c(folder_path, data$file[i]), quiet = TRUE, method = method, mode = mode)))

      # random pause
      Sys.sleep(runif(1, delay_min, delay_max))
    }

    # message
    cat("\nAll files have been downloaded!")
  }
}

###############################################################################
# end R script
###############################################################################
