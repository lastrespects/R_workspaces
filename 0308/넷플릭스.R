library(dplyr)

netflix = read.csv('netflix.csv')
#View(netflix)

result = netflix %>% slice(2)
print(result)

result = netflix %>% slice(5) %>% tail
print(result)

result = netflix %>% select(title,type,release_year)
#print(result)

#문제 8: duration 열에서 영화의 길이가 분 단위로 제공됩니다. 
#영화(type == "Movie")의 경우, duration 값을 숫자형 데이터로 변환하고 
#새로운 열 duration_minutes를 추가하세요.
result = netflix %>% filter(type == "Movie") %>% 
  mutate(duration_minutes = as.numeric(gsub(" min","",duration)))
print(result)

#문제 10: TV 프로그램(type == "TV Show") 중 시즌 수(duration)를 기준으로 오름차순으로 정렬하세요.
# []?
result = netflix %>% filter(type == "TV Show") %>%
  mutate(seasons = as.numeric(gsub(" Season[s]?","",duration))) %>%
  arrange(seasons)
print(result)
