% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fn_df.R
\name{df_indi}
\alias{df_indi}
\alias{df_fam}
\alias{df_sour}
\alias{df_repo}
\alias{df_media}
\alias{df_note}
\alias{df_subm}
\title{Summarise records of a particular type in a dataframe}
\usage{
df_indi(x, xrefs = NULL)

df_fam(x, xrefs = NULL)

df_sour(x, xrefs = NULL)

df_repo(x, xrefs = NULL)

df_media(x, xrefs = NULL)

df_note(x, xrefs = NULL)

df_subm(x, xrefs = NULL)
}
\arguments{
\item{x}{A gedcom object.}

\item{xrefs}{A vector of xrefs to summarise. If this is left NULL,
all relevant xrefs will be used.}
}
\value{
A dataframe summarising a record on each row.
}
\description{
Summarise records of a particular type in a dataframe
}
