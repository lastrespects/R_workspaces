setwd("D:/r-data") # 작업 디렉토리 변경
print(list.files()) #R 경로확인

# 데이터프레임 (행과 열(벡터))

df = data.frame(
  ID = c(1,2,3),
  Name = c('Brain','Bob','Jose')
)
# 출력
# View(df)
print(df$Name) # 특정 열 출력

df$ID2 = df$ID + 1 # 특정 열을 가져와서 값을 더한 후 새로운 열에 추가함
print(df$ID2)

# 결측치(Missing Value) 'NA'로 표기
# 예제 데이터 생성
data = c(1, 2, NA, 4, NA ,6)

# 결측치 확인
print(is.na(data)) # is ->?, is.na => na가 있니?
# na가 있으면 true, 없으면 false

print(!is.na(data)) # !(부정) 반대

## csv(콤마로 구성된 파일)파일 가져오기
emp = read.csv("emp.csv") # emp.csv파일 가져오기
#View(emp)
emp_clean = na.omit(emp) # omit : 제거하다
#View(emp_clean)

emp_comm = sum(emp$COMM, na.rm = TRUE)# rm : 제거하다
print(emp_comm)

### 문제풀이
### 데이터 전처리 -> 80~90%
### dplyr -> 데이터프레임을 다루는 공구 

library(dplyr) # 로드

# 문제1 <- select(선택하다)
selected_emp = emp %>% select(ENAME, JOB, DEPTNO)
print(selected_emp)

# 급여(SAL)가 2000 이상인 직원만 필터링하세요.
# filter : 조건(WHERE)
filtered_emp = emp %>% filter(SAL >= 2000)

# 급여(SAL)를 기준으로 내림차순으로 정렬하세요.
# arrange : 정렬
# desc : 내림차순
arranged_emp = emp %>% arrange(desc(SAL))

# 부서 번호(DEPTNO)가 30인 직원 중, => filter
# 이름(ENAME)과 급여(SAL)만 선택하고 => select
# 급여 순으로 내림차순 정렬하세요. => arrange
result = emp %>% 
  filter(DEPTNO == 30) %>% 
  select(ENAME,SAL) %>% 
  arrange(desc(SAL))
# 직업(JOB)이 "MANAGER"인 직원 중, 
# 부서 번호(DEPTNO)와 급여(SAL)를 선택하고 
# 급여 순으로 오름차순 정렬하세요.
result = emp %>% 
  filter(JOB == 'MANAGER') %>% 
  select(DEPTNO,SAL) %>% 
  arrange(SAL) # asc: 오름차순

# 급여(SAL)가 1500 이상이고 
# 부서 번호(DEPTNO)가 20인 
# 직원의 이름(ENAME), 직업(JOB), 
# 그리고 급여(SAL)를 선택한 뒤 이름 순으로 
# 정렬(오름차순)하세요.

result = emp %>% 
  filter(SAL >= 1500 & DEPTNO == 20) %>% 
  select(ENAME,JOB,SAL) %>% 
  arrange(ENAME)

# 문제 8. 부서 번호(DEPTNO)가 10 또는 30인 직원 중, 
# 이름(ENAME), 직업(JOB), 급여(SAL)을 선택하고 
# 이름 순으로 정렬하세요.
# in 연산자(or)
result = emp %>% 
  filter(DEPTNO %in% c(10,30)) %>% 
  select(ENAME,JOB,SAL) %>% 
  arrange(ENAME)
# mutate()를 사용하여 급여(SAL)에 
# 보너스(COMM, NA는 0으로 간주)를 
# 더한 총 급여(Total_Salary) 열을 추가하세요.
# mutate: 컬럼(열) 추가
# Total_Salary = SAL + COMM
result = emp %>% 
  mutate(COMM = ifelse(is.na(COMM), 0 , COMM),
         Total_Salary = SAL + COMM)
print(result)

num = c(10,10,NA,5,NA)
result = ifelse(is.na(num), 1, num)