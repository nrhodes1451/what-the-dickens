library(gutenbergr)
library(tidyverse)

id <- gutenberg_authors %>% filter(author=="Dickens, Charles") %>%
  .$gutenberg_author_id
# Save Dickens works list to CSV
gutenberg_metadata %>% filter(gutenberg_author_id==id) %>% write_csv("works_full.csv")

# Manually filtered works to remove duplicates/translations/compilations etc.
works <- read_csv("works_subset.csv")
text <- gutenberg_download(works) %>%
  left_join(works) %>%
  select(-gutenberg_id)
# Save books as RDS
text %>% saveRDS("dickens.RDS")
