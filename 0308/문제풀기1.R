# install.packages("dplyr") # 설치
library(dplyr)  # 로드
# print(list.files())
# emp, dept 불러오기
emp = read.csv('emp.csv')
dept = read.csv('dept.csv')
# 문제 1: 급여(SAL)가 3000 이상인 직원들의 이름(ENAME)과 
# 직업(JOB)을 출력하세요.
result = emp %>% filter(SAL >= 3000) %>% select(ENAME,JOB)

# 문제 2: "RESEARCH" 부서에 근무하는 직원들의 
# 이름(ENAME)과 급여(SAL)를 출력하세요.
# 병합 후 필터링!
result = emp %>% inner_join(dept, by = "DEPTNO") %>%
  filter(DNAME == 'RESEARCH') %>%
  select(ENAME, SAL)

# 문제 3: 직업(JOB)별 평균 급여(SAL)를 계산하고 출력하세요.
# group by, mean
result = emp %>% group_by(JOB) %>%
  summarise(AVG_SAL = mean(SAL, na.rm = TRUE))

# 문제 4: 각 부서(DNAME)별 직원 수를 계산하고 출력하세요.
# 1. inner join
# 2. group by
# 3. n() (SQL ==  count())

result = emp %>% inner_join(dept, by = "DEPTNO") %>%
  group_by(DNAME) %>% 
  summarise(EMP_COUNT = n())

# 고용일(HIREDATE)이 "1981-01-01" 이후인 
# 직원들의 이름(ENAME), 직업(JOB), 고용일(HIREDATE)을 
# 출력하세요.

# 1. filter
# 2. select
result = emp %>% filter(HIREDATE > as.Date('1981-01-01')) %>%
  select(ENAME,JOB,HIREDATE)

# 부서별(DEPTNO)로 그룹화하여 총 
# 급여(SAL)의 합계를 계산하고 출력하세요.

result = emp %>% group_by(DEPTNO) %>%
  summarise(TOTAL_SAL = sum(SAL))

# ***커미션(COMM)이 결측치가 아닌 직원들의 
# 이름(ENAME), 커미션(COMM)을 출력하세 요.
result = emp %>% filter(!is.na(COMM)) %>%
  select(ENAME, COMM)

# "SALES" 부서에서 근무하는 직원들의 이름(ENAME), 급여(SAL), 커미션(COMM)을 출력하세요.
# 병합하는 문제가 나오면 무조건 1순위는 join입니다.
result = emp %>% inner_join(dept, by = "DEPTNO") %>%
  filter(DNAME == "SALES") %>%
  select(ENAME,SAL,COMM)
# 각 부서(DNAME)별로 가장 높은 급여를 받는 직원의 이름(ENAME)과 급여(SAL)를 출력하세요.
# sclice_max , n 
result = emp %>% inner_join(dept, by = "DEPTNO") %>%
  group_by(DNAME) %>%
  slice_max(SAL, n = 1)
select(ENAME, SAL)
# 직업(JOB)이 "MANAGER"인 직원들의 이름(ENAME), 부서명(DNAME), 급여(SAL)을 출력하세요.
result = emp %>% inner_join(dept, by = "DEPTNO") %>%
  filter(JOB == 'MANAGER') %>%
  select(ENAME, DNAME, SAL)