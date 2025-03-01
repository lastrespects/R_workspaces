# R 디렉토리 변경
setwd('D:/r-data')
print(list.files()) # 해당 경로 파일 확인

#CSV(엑셀) 불러오기
data = read.csv('student_data.csv')
# View(data)

# 각 과목(Math, Science, English)의 평균 점수를 계산하세요
# ****mean
math = mean(data$Math) #Math컬럼(열) 평균 구하기
cat('수학 평균 : ',math,'\n')
science = mean(data$Science) 
cat('과학 평균 : ',science,'\n')
english = mean(data$English) 
cat('영어 평균 : ',english,'\n')

#컴퓨터 총합 구하시오. 단, 결측값 제거(na.rm = TRUE)
computer = sum(data$Computer,na.rm= TRUE) 
cat('컴퓨터 평균 : ',computer,'\n')

# 영어 표준편차 구하기
# sd = standard deviation(표준편차)
english_sd = sd(data$English)
cat('영어 표준편차 : ', english_sd, '\n')# 영어 값들이 평균으로부터
# (+-)4.9만큼 퍼져있다는 것을 의미합니다.

# 과학 중앙값 구하기
science_median = median(data$Science)
print(science_median)

# 수학 사분위수 구하기
math_q = quantile(data$Math)
print(math_q)

# 최댓값, 최솟값
# 수학 과목의 최댓값, 최솟값 구해보기
math_max = max(data$Math) # 최댓값
math_min = min(data$Math) # 최솟값
cat('최댓값 : ',math_max,'\n')
cat('최솟값 : ',math_min,'\n')

# table
print(table(data$English)) #점수별 인원 통계

# 데이터프레임 기초 통계량 전체 확인
# summary 사용하면 각 컬럼(열)별 기본 통계 확인
print(summary(data))

#install.packages("ggplot2")
library(ggplot2)

graph_data = data.frame(
  x = c('수학평균','영어평균','과학평균'),
  y = c(math,english,science) #각 과목 평균값
  )

#그래프 생성
result = ggplot(data = graph_data, aes(x = x, y = y)) +
  geom_col(fill = 'steelblue') +
  labs(
    title = "과목 평균",
    x = "과목",
    y = "평균점수"
  )+
  theme_minimal()
print(result)
