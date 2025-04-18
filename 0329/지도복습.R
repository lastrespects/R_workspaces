library(ggplot2) #그래프 도구
library(dplyr) #전처리 도구
library(sf) # 지도 시각화
library(ggiraph) #지도 시각화 이벤트

korea_map = st_read('sig.shp')

# 서울만 가져오기
seoul_map = korea_map %>%
  filter(substr(SIG_CD, 1, 2)== '11')

# 미세먼지 데이터 불러오기
dust_data = read.csv('data.csv',
                           fileEncoding = 'CP949',
                           encoding = 'UTF-8',
                           check.names = FALSE)
#View(dust_data)
# 미세먼지 station_code(지역코드)
# 퀴즈
# join을 이용해서 shp파일과 data.csv 병합하기

dust_data = dust_data %>%
  mutate(station_code = as.character(station_code))

# 교집합 컬럼 데이터 타입이 동일해야 병합 가능
merged_data = inner_join(seoul_map , dust_data, by = c('SIG_CD' = 'station_code'))
#View(merged_data)

# 심플 지도
# 지도는 x축 경도 y는 위도 정해져있음
p = ggplot(data = merged_data) +
  geom_sf(aes(fill = pm10_concentration_ug_m3), color = "black") + #지도 색깔 채우기
  scale_fill_gradient(low = "blue", high = "red", name = "미세먼지농도") +
  theme_minimal() + #회색 배경 제거
  labs(title = "서울시 미세먼지 농도", x = "경도", y ="위도")
print(p)

# 숙제 1. 24년도 총 직장 인구수가 가장많은 자치구 5개만 지도로 표현
# 숙제 2. 24년도 서울 총 직장인 인구 수 대비 각 자치구 직장인 인구 수 비율 구하기(group by + summ)


  