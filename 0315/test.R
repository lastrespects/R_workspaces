#install.packages("dplyr")
library(dplyr)
netflix = read.csv('netflix.csv') #데이터셋 읽기
# 3번 데이터셋에서 title, type, release_year 열만 선택하세요.
result = netflix %>% select('title','type', 'release_year')
# 6번 'TV-MA 등급'의 'TV 프로그램'만 필터링하세요.
result = netflix %>% 
  filter(type == 'TV Show' & rating == 'TV-MA')
# 7번 director가 "Mike Flanagan"인 영화의 
# title, director, country 열을 선택하세요.
result = netflix %>% 
  filter(type == 'Movie' & director == 'Mike Flanagan') %>%
  select(title, director, country)
# 문제 10: TV 프로그램(type == "TV Show") 중 
# 시즌 수(duration)를 기준으로 오름차순으로 정렬하세요.
# 문제발생: 'duration' 컬럼에 숫자와 문자가 존재함.
# 문자열을 제거(특정 문자로 대체) -> gsub
# *텍스트 데이터에서 숫자만 추출 뒤 정렬하는게 포인트
result = netflix %>% 
  filter(type == "TV Show") %>%
  mutate(seansons = as.numeric(gsub(' Season[s]?',"",duration))) %>%
  arrange(seansons)
