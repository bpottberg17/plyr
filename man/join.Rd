% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/join.r
\name{join}
\alias{join}
\title{Join two data frames together.}
\usage{
join(x, y, by = NULL, type = "left", match = "all")
}
\arguments{
\item{x}{data frame}

\item{y}{data frame}

\item{by}{character vector of variable names to join by. If omitted, will
match on all common variables.}

\item{type}{type of join: left (default), right, inner or full.  See
details for more information.}

\item{match}{how should duplicate ids be matched? Either match just the
\code{"first"} matching row, or match \code{"all"} matching rows. Defaults
to \code{"all"} for compatibility with merge, but \code{"first"} is
significantly faster.}
}
\description{
Join, like merge, is designed for the types of problems
where you would use a sql join.
}
\details{
The four join types return:

\itemize{
 \item \code{inner}:  only rows with matching keys in both x and y
 \item \code{left}:   all rows in x, adding matching columns from y
 \item \code{right}:  all rows in y, adding matching columns from x
 \item \code{full}:   all rows in x with matching columns in y, then the
   rows of y that don't match x.
}

Note that from plyr 1.5, \code{join} will (by default) return all matches,
not just the first match, as it did previously.

Unlike merge, preserves the order of x no matter what join type is used.
If needed, rows from y will be added to the bottom.  Join is often faster
than merge, although it is somewhat less featureful - it currently offers
no way to rename output or merge on different variables in the x and y
data frames.
}
\examples{
first <- ddply(baseball, "id", summarise, first = min(year))
system.time(b2 <- merge(baseball, first, by = "id", all.x = TRUE))
system.time(b3 <- join(baseball, first, by = "id"))

b2 <- arrange(b2, id, year, stint)
b3 <- arrange(b3, id, year, stint)
stopifnot(all.equal(b2, b3))
}
\keyword{manip}
