# 특정 지역의 상권 생존률과 폐업률 알아내기
# 가중치 없이
library(dplyr) # 전처리 도구
library(ggplot2) # 그래프 도구

# 2024년도 통계를 가지고 2025년도 생존률, 폐업률 예상하기.
# 분기로 되어있음.
# substr을 이용해서 2024 1분기부터 4분기까지
#운영_영업_개월_평균, 폐업_영업_개월_평균
#서울_운영_영업_개월_평균, 서울_폐업_영업_개월_평균
# 총 4개의 컬럼 평균 구하기.

seoul_commercial_data = read.csv('seoul_commercial_analysis.csv',
                                 fileEncoding = 'CP949', 
                                 encoding = 'UTF-8', 
                                 check.names = FALSE)

# 분기로 되어있는 데이터를 년도로 바꾸자


seoul_commercial_data = seoul_commercial_data %>%
  mutate(year = substr(기준_년분기_코드,1,4))

# View(seoul_commercial_data)

seoul_2024_data = seoul_commercial_data %>%
  filter(year == 2024) %>%
  group_by(자치구_코드_명) %>%
  summarise(
    평균폐업 = mean(폐업_영업_개월_평균),
    평균운영 = mean(운영_영업_개월_평균),
    서울전체평균운영 = mean(서울_운영_영업_개월_평균),
    서울전체평균폐업 = mean(서울_폐업_영업_개월_평균)
  )
#View(seoul_2024_data)

# 서초구 생존확률
# 2024년도 데이터가 없어서 2022년도 대체
seochogu_live_rate = 33 #24년 서초구 생존율 -> 33% 가정
seochogu_close_rate = 32 #24년 서초구 폐업율 -> 32% 가정

# 서초구 평균 영업,평균 폐업 조회
seochogu = seoul_2024_data %>%
  filter(자치구_코드_명 == '서초구') %>%
  select(평균운영, 평균폐업)
#View(seochogu)

#2025년 서초구 상권 생존율/폐업률 계산
생존확률_2025 = seochogu_live_rate * 
  (seochogu$평균운영 / (seochogu$평균운영 +seochogu$평균폐업))
폐업확률_2025 = seochogu_close_rate * 
  (seochogu$평균폐업 / (seochogu$평균운영 +seochogu$평균폐업))

# 결과 출력
# %.2f%% -> 소수점 2자리 까지만 출력하겠다.
cat(
  sprintf('2025년 서초구 상권 생존확률 예상 : %.2f%%\n',생존확률_2025),
  sprintf('2025년 서초구 상권 폐업확률 예상 : %.2f%%',폐업확률_2025)
)

# 종로구 생존확률, 폐업확률 구해보기
# 24년 종로구 상권 생존율 20%
# 24년 종로구 상권 폐업율 35% 라고 가정.
jongnogu = seoul_2024_data %>%
  filter(자치구_코드_명 == '종로구') %>%
  select(평균운영, 평균폐업)

jongnogu_live_rate = 20 # 24년 종로구 생존율
jongnogu_close_rate = 25 # 24년 종로구 폐업율

# 2025년 종로구 상권 생존율/폐업률 계산
종로구_생존확률_2025 = jongnogu_live_rate * 
  (jongnogu$평균운영 / (jongnogu$평균운영 + jongnogu$평균폐업))

종로구_폐업확률_2025 = jongnogu_close_rate * 
  (jongnogu$평균폐업 / (jongnogu$평균운영 + jongnogu$평균폐업))

# 결과 출력
# %.2f%% -> 소수점 2자리 까지만 출력하겠다.
cat(
  sprintf('2025년 종로구 상권 생존확률 예상 : %.2f%%\n',종로구_생존확률_2025),
  sprintf('2025년 종로구 상권 폐업확률 예상 : %.2f%%',종로구_폐업확률_2025)
)
# 영업/폐업 지속 개월수를 고려한 비율 계산



  