# 종로구하고 중구,용산구가 현재 가장 폐업율이 높다.
# 왜 높을까? 
# 1. 물가 상승 2. 노인 수 급증

# 노인 수가 많을 것 이다.(추측)
# 종로구 노인 인구 비율을 조회해보자.

library(dplyr) # 전처리 도구
library(ggplot2) # 그래프 도구

elder = read.csv('고령인구현황.csv',
                 fileEncoding = 'CP949', 
                 encoding = 'UTF-8', 
                 check.names = FALSE)

# 전처리
# 종로구의 22년,23년,24년 65세이상전체 컬럼 조회
elder_group = elder %>%
  filter(행정구역 == '서울특별시 종로구 (1111000000)') %>%
  select(`2022년_65세이상전체`, 
         `2023년_65세이상전체`, 
         `2024년_65세이상전체`)
# View(elder_group)
# 변화된 데이터를 선 그래프로 표현

df = data.frame(
  #뒤에 월과 일은 꼭 입력해야합니다.
  time = c('2022-01-01','2023-01-01','2024-01-01'),
  elder_count = c(
    elder_group$`2022년_65세이상전체`,
    elder_group$`2023년_65세이상전체`,
    elder_group$`2024년_65세이상전체`))
# 형변환
df$time = as.Date(df$time)#문자 -> 날짜
df$elder_count = as.numeric(
  gsub(",","",df$elder_count) #콤마 제거 후 숫자로 변환
)
print(df) # 결과확인

p = ggplot(data = df, aes(x = time, y = elder_count)) +
  geom_line() +
  labs(title = "종로구 인구수 변화",
       x = "연도",
       y = "노인(65세 이상) 수")
print(p) # 그래프 확인

# 상승률 계산
# 상승률 : 최종 값 - 초기 값 / 초기 값 * 100
# 올해 - 작년 / 작년 * 100
# increase_rate 컬럼 생성
# diff: 연속된 값들 사이의 차이를 계산
df$increase_rate = 
  c(0, diff(df$elder_count) / 
      df$elder_count[-length(df$elder_count)] * 100 )

# print(df) # 상승률 확인

# diff: 연속된 값들 사이의 차이를 계산
x = c(10,20,30,40)
print(diff(x)) # 20-10 / 30-20 / 40-30

# length : 길이
print(length(df$elder_count)) #데이터 수(길이) == count
print(df$elder_count[-3]) # 3번째 데이터 빼고 출력

#View(df)

# 폐업 확률 구해보자
# 폐점 확률(가중평균)
# 노인율 = 초기노인율 + 노인증가율(v)
# 폐업율 = 초기폐점율 + 폐업증가율

# 가중치는 우리가 정하는 것
# 전체 가중치 합 1
# 노인 가중치 0.6(유동인구 증가, 노인 소비패턴...)
#폐업 가중치 0.4(임대료상승, 경기침체...)

# 폐점 확률 = (노인율 *  노인 가중치) + (폐점율 * 폐점 가중치)

# 노인율 

elder2 = read.csv('2022_2024_주민등록인구기타현황(고령 인구현황)_연간.csv',
                  fileEncoding = 'CP949', 
                  encoding = 'UTF-8', 
                  check.names = FALSE)
# 콤마 제거하기
# 2024년_전체, 2024년_65세이상 전체 컬럼들 콤마 제거하기(디플리알)

elder2 = elder2 %>%
  mutate(
    인구수_2024 = as.numeric(gsub(",","",`2024년_전체`)),
    노인수_2024 = as.numeric(gsub(",","",`2024년_65세이상전체`)),
    인구수대비노인율 = (노인수_2024 / 인구수_2024) * 100
  )

#View(elder2)

# 초기노인율(2024년 가정)
jongno_init_elder_rate = elder2 %>%
  filter(행정구역 == '서울특별시 종로구 (1111000000)') %>%
  select(인구수대비노인율)

print(jongno_init_elder_rate) # 결과 확인

# 노인율 = 초기노인율 + 노인증가율
jongno = jongno_init_elder_rate + df$increase_rate + 3.7
# 폐업율 = 초기폐점율 + 폐업증가율
close =  13 #가정

# 가중치 설정
# 가중치 0.6과 0.4 설정 이유
# 두 요인의 상대적 기여도 비율 6:4 라고 가정
elder_w = 0.6 #노인 가중치(노인인구수 증가,유동인구 감소 등...)
close_w = 0.4 #폐점 가중치(임대료 상승,경기침체 등...)

# 최종 폐점 확률(종로구)
close_rate = (jongno * elder_w) + (close * close_w)
print('종로구에 신규오픈 시 예상 폐점 확률 : ')
print(close_rate$인구수대비노인율) #폐점확률 20%







