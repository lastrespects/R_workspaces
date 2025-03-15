Sys.setlocale("LC_TIME","C") #임시로 장소변경경

data_str = 'September 24, 2021'
#R은 해당 문자를 바로 날짜형으로 변환할 수 없다.
date_str = as.Date(date_str, format = '%B %d, %Y')
print(date_str)
formatted_date = format(date_str, '%Y') #년도만 나오게게
print(formatted_date)

date_str_1 = '2025-03-15'
date = as.Date(date_str_1)#