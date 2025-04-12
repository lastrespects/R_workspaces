# 주어진 코드
x = 42
y = "R 프로그래밍"
z = TRUE

# 각 변수의 자료형을 출력하는 코드를 작성하세요.
# 힌트: typeof() 함수를 사용하세요.

print(typeof(x))
print(typeof(y))
print(typeof(z))
cat(typeof(x),typeof(y),typeof(z),'\n')

# 다음 벡터에서 20보다 큰 숫자만 선택하여 출력하세요.
# 주어진 벡터
numbers = c(10, 15, 20, 25, 30, 35)
# 20보다 큰 숫자만 선택하고 출력하는 코드를 작성하세요.
than_20 = numbers[numbers > 20]
print(than_20)

# 주어진 데이터프레임
people = data.frame(
  name = c("Alice", "Bob", "Charlie", "Diana"),
  age = c(25, 35, 30, 28),
  gender = c("여", "남", "남", "여")
)

# 힌트 : head
print(head(people),5)
#힌트: dim
print(dim(people))
#힌트: colnames
print(colnames(people))

# 힌트: data[row_condition, column_condition] 콤마를 기준으로 왼쪽은 행 조건, 오른쪽은 열 조건입니다. 
result = people[gender,3]
  
