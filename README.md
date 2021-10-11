
# downloadr

`downloadr` is a very simple `R` package with an easy-to-use function called `download_files()` for . . .  downloading files. 

If you're going to be extracting data from a website, it's always best, for replicability, to download the source `HTML`. Also, you might realize later that you need to redo something (maybe your parsing code didn't do work the way you expacted, or you realize you need to extract additional information), and you don't want to tax the site's servers by requesting all of the `HTML` pages again. 

`download_files()` is a wrapper around the base `R` function `download.file()` that adds some very useful functionality. `download_files()` has three key features:

- It's vectorized. You give it a list of URLs and a corresponding list of file names, and it will download all of the files without you having to write a loop. 
- It checks to see if you've already downloaded any of the files. If you're downloading a lot of files, you might need to stop and restart your code before it finishes. If you're running a loop, you have to figure out where to start again, which is annoying. `download_files` looks in the folder you're saving the files to and checks to see if you've already downloaded any of them. Unless you tell it otherwise, it'll skip the ones you've already done. When you run it, it'll tell you how many you've already download and how many are left to download. 
- It pauses randomly between downloaded files. You give it a minimum and maximum delay, and it'll insert a random delay between downloads. This is an important courtesy to the site's server. You don't want to download files to quickly and tax the server's capacity or, even worse, be mistaken for a denial of service attack. 

**Important:** You should always scrape the web ethically. Always use a sufficient random delay between downloading files from a server, and always follow the site's terms of service and `robots.txt` file. It's always better to use an API if one's available. If you need to download a substantial number of files, it's always better to ask the site's administrator first. They might be able to give you what you need. If a site's administrator doesn't want you to download files automatically, don't do it. 

## Installation

You can install the latest development version of the `downloadr` package from GitHub:

```r
# install.packages("devtools")
devtools::install_github("jfjelstul/downloadr")
```

## Citation

If you use data from the `downloadr` package in a project or paper, please cite the package:

> Joshua Fjelstul (2021). downloadr: An R Function for Downloading Files. R package version 0.1.0.9000.

The `BibTeX` entry for the package is:

```
@Manual{,
  title = {downloadr: An R Function for Downloading Files},
  author = {Joshua Fjelstul},
  year = {2021},
  note = {R package version 0.1.0.9000},
}
```

## Problems

If you notice an error in the data or a bug in the `R` package, please report it [here](https://github.com/jfjelstul/downloadr/issues).

## Example: Downloading Pages from Wikipedia

The `download_files()` function is extremely easy to use. First, let's make some example data. We'll make a `tibble` with two variables: one called `url` that has the URL address for five Wikipedia articles about the major EU institutions and another called `file` that has a file name to each for each downloaded `HTML` file. 

```r
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
```

Now that we have some URL addresses and file names, we can download the files. All we need to do is pass in the two variables from our `tibble`, specify a minimum and maximum delay (in seconds) between downloads, and set the path of the folder where you want to save the files (the trailing `/` in the path is optional). 

```r
download_files(
  urls = data$url,
  files = data$file,
  delay_min = 3,
  delay_max = 5,
  folder_path = "example/downloaded-files/"
)
# Done: 3 of 5 files already downloaded.
# To do: 2 files to download.                                   
# Downloading file 2 of 2...                                                                          
# All files have been downloaded!
```

And that's it! The function will print a message to the console so you know how many files have already been downloaded (3 in this example) and how many are left to go (2 more). It will update you on its progress in live time and print another update to the console when it's finished. 
