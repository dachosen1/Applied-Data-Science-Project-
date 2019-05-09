percentage.table <- function(x, digits = 1){
 tab <- table(x)
 percentage.tab <- 100*tab/(sum(tab))
 rounded.tab <- round(x = percentage.tab, digits = digits)
 return(rounded.tab)
}
round.numerics <- function(x, digits){
 if(is.numeric(x)){
  x <- round(x = x, digits = digits)
 }
 return(x)
}
miss.value <- function(x){
 miss.rate <- round(100*mean(is.na(x)),2)
 return(miss.rate)
}
get.unique = function(x){
 ux=length(unique(x))
 return(ux)
}
## create formula
create.formula <- function(outcome.name, input.names, input.patterns=NA, all.data.names=NA, return.as="character"){
 variable.names.from.patterns <- c()
 if (!is.na(input.patterns[1]) & !is.na(all.data.names[1])) {
  pattern <- paste(input.patterns, collapse = "|")
  variable.names.from.patterns <- all.data.names[grep(pattern = pattern, x = all.data.names)]
 }
 all.input.names <- unique(c(input.names, variable.names.from.patterns))
 all.input.names <- all.input.names[all.input.names !=outcome.name]
 if (!is.na(all.data.names[1])) {
  all.input.names <- all.input.names[all.input.names %in% all.data.names]
 }
 input.names.delineated <- sprintf("`%s`", all.input.names)
 the.formula <- sprintf("`%s` ~ %s", outcome.name, paste(input.names.delineated, collapse = " + "))
 if (return.as == "formula") {
  return(as.formula(the.formula))
 }
 if (return.as != "formula") {
  return(the.formula)
 }
}

reduce.formula <- function(dat, the.initial.formula, max.categories = NA) {
 require(data.table)
 dat <- setDT(dat)
 
 the.sides <- strsplit(x = the.initial.formula, split = "~")[[1]]
 lhs <- trimws(x = the.sides[1], which = "both")
 lhs.original <- gsub(pattern = "`", replacement = "", x = lhs)
 if (!(lhs.original %in% names(dat))) {
  return("Error: Outcome variable is not in names(dat).")
 }
 the.pieces.untrimmed <- strsplit(x = the.sides[2], split = "+", fixed = TRUE)[[1]]
 the.pieces.untrimmed.2 <- gsub(pattern = "`", replacement = "", x = the.pieces.untrimmed, fixed = TRUE)
 the.pieces.in.names <- trimws(x = the.pieces.untrimmed.2, which = "both")
 
 the.pieces <- the.pieces.in.names[the.pieces.in.names %in% names(dat)]
 num.variables <- length(the.pieces)
 include.pieces <- logical(num.variables)
 
 for (i in 1:num.variables) {
  unique.values <- dat[, unique(get(the.pieces[i]))]
  num.unique.values <- length(unique.values)
  if (num.unique.values >= 2) {
   include.pieces[i] <- TRUE
  }
  if (!is.na(max.categories)) {
   if (dat[, is.character(get(the.pieces[i])) | is.factor(get(the.pieces[i]))] == TRUE) {
    if (num.unique.values > max.categories) {
     include.pieces[i] <- FALSE
    }
   }
  }
 }
 pieces.rhs <- sprintf("`%s`", the.pieces[include.pieces == TRUE])
 rhs <- paste(pieces.rhs, collapse = " + ")
 the.formula <- sprintf("%s ~ %s", lhs, rhs)
 return(the.formula)
}

# calculating relative term frequency (TF)
term.frequency <- function(row) {
 row / sum(row)
}

# calculating inverse document frequency (IDF)
inverse.doc.freq <- function(col) {
 corpus.size <- length(col)
 doc.count <- length(which(col > 0))
 
 log10(corpus.size / doc.count)
}

# calculating TF-IDF.
tf.idf <- function(x, idf) {
 x * idf
}
text.prep=function(dat,var.name){
 # tokenization
 dat.token=tokens(dat[,get(var.name)],what="word", remove_punct=T, remove_symbols=T, remove_hyphens = T)
 # lower case the tokens
 dat.token=tokens_tolower(dat.token)
 # stopword removal
 dat.token=tokens_select(dat.token,stopwords(),selection = "remove")
 # stemming
 dat.token=tokens_wordstem(dat.token,language = "english")
 return(dat.token)
}

linear.regression.summary <- function(lm.mod, digits = 3, alpha = 0.05) {
 lm.coefs <- as.data.table(summary(lm.mod)$coefficients,
                           keep.rownames = TRUE)
 setnames(x = lm.coefs, old = "rn", new = "Variable")
 z <- qnorm(p = 1 - alpha/2, mean = 0, sd = 1)
 lm.coefs[, Coef.Lower.95 := Estimate - z * `Std. Error`]
 lm.coefs[, Coef.Upper.95 := Estimate + z * `Std. Error`]
 return(lm.coefs[])
}