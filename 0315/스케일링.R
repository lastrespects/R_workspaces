# *****데이터스케일링
# 데이터 분석` 및 `머신러닝`에 중요한 전처리 과정
# 변수의 크기를 조정하여 성능을 향상시키거나 결과를 
# 해석하기 쉽게 만든다.

# Min-Max 정규화
# 데이터 스케일링 방법중 하나(대표적인)
# Min-Max는 데이터를 0에서 1사이로 변환하는 데이터 전처리 기법

# 예제 데이터 프레임
data = data.frame(
  height = c(150, 160, 170, 180, 190),
  weight = c(50, 60, 70, 80, 90)
)
# View(data)
# 키와 몸무게는 단위와 범위가 다르기 때문에
# 두 데이터를 그대로 비교하거나 분석하기 어렵다.
# 이를 해결하기 위해 키와 몸무게를 0~1 사이로 스케일링하면
# 두 변수는 동일한 기준에서 비교할 수 있습니다.

# 스케일링값 = (원래 값 - 최솟값) / (최댓값 - 최솟값)

height_min = min(data$height) # 키 최솟값
height_max = max(data$height) # 키 최댓값

data$scaled_height = (data$height - height_min) / (height_max - height_min)

weight_min = min(data$weight)
weight_max = max(data$weight)

data$scaled_weight = (data$weight - weight_min) / (weight_max - weight_min)

#View(data)

# emp 데이터에서 급여(SAL) 열에 대해 Min-Max 
#정규화를 수행해주세요.(SAL_MinMax 컬럼 추가가)
# 디플리알로 0.5보다 큰 값을 가지는 데이터 추출.
library(dplyr)
emp = read.csv('emp.csv')

sal_min = min(emp$SAL, na.rm = TRUE)
sal_max = max(emp$SAL, na.rm = TRUE)
emp$SAL_MinMax = (emp$SAL - sal_min) / (sal_max - sal_min)
View(emp)

# 0.5보다 큰 값을 가지는 데이터 추출
result = emp %>% filter(SAL_MinMax >= 0.5) %>%
  select(ENAME,SAL,SAL_MinMax)%>%
  arrange(desc(SAL_MinMax))
print(result)