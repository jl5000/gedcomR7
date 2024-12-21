
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gedcomS7

<!-- badges: start -->
<!-- badges: end -->

The goal of `gedcomS7` is to handle genealogical data as GEDCOM files.
This package succeeds the `tidyged` package and many of the other
packages in the `gedcompendium`. The key changes are:

- The package is designed to work with GEDCOM 7.0, rather than 5.5.5.
- The package has minimal dependencies; currently only one:
  [`S7`](https://rconsortium.github.io/S7/).
- GEDCOM files are stored as S7 objects rather than dataframes.
- The package contains all functionality to create, edit, and
  interrogate GEDCOM files.

## Installation

You can install the development version of gedcomS7 from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("jl5000/gedcomS7")
```

## Key limitations

When importing existing GEDCOM files, you should ensure that they are
error free. This package assumes imported GEDCOM files are valid and
very few validation checks are carried out. Several GEDCOM validators
are available, including an online validator at
<https://ged-inline.org/>.

The package does not currently support extension tags. If you import a
file with these features, the package may behave unpredictably.

## Example

GEDCOM files can be imported or created from scratch, creating an S7
object representation:

``` r
library(gedcomS7)

ged <- read_gedcom("https://gedcom.io/testfiles/gedcom70/remarriage1.ged")

ged <- new_gedcom()
ged
#> GEDCOM file summary:
#>  
#> GEDCOM version:         7.0
#> Creation Date:          19 DEC 2024
#> Default Language:       en
#> Submitter:              <Undefined>
#> 
#> Copyright:              <Undefined>
#> 
#> Source system:          https://github.com/jl5000/gedcomS7
#> Product name:           The 'gedcomS7' package for the R language
#> Source system version:  <Undefined>
#> 
#> Submitters:             0
#> Individuals:            0
#> Families:               0
#> Sources:                0
#> Repositories:           0
#> Multimedia:             0
#> Notes:                  0
```

The metadata for the gedcom object (ged@…) can be modified.

``` r
ged@notes <- "This file contains my family tree"
ged@gedcom_copyright <- "Copyright Jamie Lendrum 2023"
ged
#> GEDCOM file summary:
#>  
#> GEDCOM version:         7.0
#> Creation Date:          19 DEC 2024
#> Default Language:       en
#> Submitter:              <Undefined>
#> 
#> Copyright:              Copyright Jamie Lendrum 2023
#> 
#> Source system:          https://github.com/jl5000/gedcomS7
#> Product name:           The 'gedcomS7' package for the R language
#> Source system version:  <Undefined>
#> 
#> Submitters:             0
#> Individuals:            0
#> Families:               0
#> Sources:                0
#> Repositories:           0
#> Multimedia:             0
#> Notes:                  0
```

New records can be created and ‘pushed’ to the GEDCOM object:

``` r
subm_record <- SubmitterRecord(subm_name = "Jamie Lendrum")
indi_record <- IndividualRecord(sex = "M",
                                pers_names = PersonalName("Joe /Bloggs/"))
sour_record <- SourceRecord(full_title = "Census of England and Wales, 1921")

ged <- ged |> 
  push_record(subm_record) |> 
  push_record(indi_record) |> 
  push_record(sour_record)
#> New Submitter record added with xref @U1@
#> New Individual record added with xref @I1@
#> New Source record added with xref @S1@
```

Existing records, must be ‘pulled’ from the object, edited, and then
‘pushed’ back.

``` r
joe_bloggs <- pull_record(ged, "@I1@")
joe_bloggs@notes <- "He had a dog called Rover"
ged <- push_record(ged, joe_bloggs)
```

The entire GEDCOM representation can be seen with the `@c_as_ged`
property:

``` r
ged@c_as_ged
#>  [1] "0 HEAD"                                          
#>  [2] "1 GEDC"                                          
#>  [3] "2 VERS 7.0"                                      
#>  [4] "1 SOUR https://github.com/jl5000/gedcomS7"       
#>  [5] "2 NAME The 'gedcomS7' package for the R language"
#>  [6] "2 CORP Jamie Lendrum"                            
#>  [7] "3 EMAIL jalendrum@gmail.com"                     
#>  [8] "1 DATE 19 DEC 2024"                              
#>  [9] "1 COPR Copyright Jamie Lendrum 2023"             
#> [10] "1 LANG en"                                       
#> [11] "1 NOTE This file contains my family tree"        
#> [12] "0 @U1@ SUBM"                                     
#> [13] "1 NAME Jamie Lendrum"                            
#> [14] "0 @I1@ INDI"                                     
#> [15] "1 NAME Joe /Bloggs/"                             
#> [16] "1 SEX M"                                         
#> [17] "1 NOTE He had a dog called Rover"                
#> [18] "0 @S1@ SOUR"                                     
#> [19] "1 TITL Census of England and Wales, 1921"        
#> [20] "0 TRLR"
```

The object can be exported to a GEDCOM file:

``` r
write_gedcom(ged, "my_gedcom.ged")
```

## References

1.  The FamilySearch GEDCOM Specification, Prepared by the Family
    History Department, The Church of Jesus Christ of Latter-day Saints.
    <https://gedcom.io/specifications/FamilySearchGEDCOMv7.html>

## Notice

> This work comprises, is based on, or is derived from the FAMILYSEARCH
> GEDCOM™ Specification, © 1984-2023 Intellectual Reserve, Inc. All
> rights reserved.

> “FAMILYSEARCH GEDCOM™” and “FAMILYSEARCH®” are trademarks of
> Intellectual Reserve, Inc. and may not be used except as allowed by
> the Apache 2.0 license that governs this work or as expressly
> authorized in writing and in advance by Intellectual Reserve, Inc.