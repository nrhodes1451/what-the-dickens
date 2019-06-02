library(gutenbergr)
library(tidyverse)

id <- gutenberg_authors %>% filter(author=="Dickens, Charles") %>%
  .$gutenberg_author_id
# Save Dickens works list to CSV
gutenberg_metadata %>% filter(gutenberg_author_id==id) %>% write_csv("works_full.csv")

# Manually filtered works to remove duplicates/translations/compilations etc.
works <- read_csv("works_subset.csv")
corpus <- gutenberg_download(works) %>%
  left_join(works) %>%
  select(-gutenberg_id)

books = corpus$title %>% unique

book = books[1]
df = corpus %>% filter(title == work) %>%
  filter(text!="") %>%
  mutate(text = trimws(text)) %>%
  filter(substr(text, 1, 7)!="Chapter")
text = df$text %>% paste(collapse = " ") %>%
  str_replace_all("Mr\\. ", "Mr\\.") %>%
  str_replace_all("Mrs\\. ", "Mrs\\.")
text <- text %>%
  str_split("\\. ") %>%
  data.frame %>% as_tibble
names(text) = "text"
text$text <- text$text %>%
  str_replace_all("Mrs\\.", "Mrs\\. ") %>%
  str_replace_all("Mr\\.", "Mr\\. ")
text$text <- as.character(text$text)
text$title = book

# Save books as csv
text %>% write_csv("dickens.csv")
