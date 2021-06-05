---
layout: post
title:  스택오버플로우 FAQ - 스파크 데이터프레임 핸들링
date:   1986-12-30 00:00:00 +0900
author: 김도영
tags: python spark
excerpt: 스파크 데이터프레임을 핸들링할때 유용한 깨알같은 팁을 정리했습니다.
toc: true
use_math: false
# tags: 자동 수집되는 태그 띄어쓰기로 구분, 반드시 소문자로 사용
# excerpt: 메인 화면에 노출되는 post의 description
# toc : 목차가 필요 할 경우 true | false
# use_math : 수식이 필요 할 경우(윗 첨자, 아랫첨자 동시 사용 불가) true | false
# emoji 사이트: https://getemoji.com/
---

# 스파크 데이터프레임 핸들링, 이럴땐 어떻게?
> 단순한 pyspark function은 쉽게 학습하여 사용할 수 있지만, 그것만으로는 부족할 때가 있다. <br/> 그럴 때마다 참새처럼 스택오버플로우를 들락날락하게 되는데, 그 과정에서 얻은 소소한 팁을 정리해두려 한다.

<br/>
<br/>

## 다수의 column에 반복작업하기
<hr/>
다수의 column에 같은 function을 적용할 때에는 아래와 같은 방법으로 해결할 수 있다.
<br/>
개인적으로는 특정 method를 반복할 때에는 for loop이, agg 안에서 같은 함수를 반복할 때에는 list comprehension이 편했다.

([이 medium post](https://mrpowers.medium.com/performing-operations-on-multiple-columns-in-a-pyspark-dataframe-36e97896c378)의 내용을 옮김)
<br/>
<br/>

### reduce
정석적인 방법이지만, 파이써닉하지 못하다.<br/>
첫번째 파라미터로는 함수가 들어가게 된다. (아래처럼 람다일 수도 있고, 정의된 함수일수도 있음)<br/>
두번째 파라미터는 iterable한 형태의 데이터, 세번째 파라미터는 초기값이다. 초기값을 원본 df로 설정해준다.
```shell
actual_df = (reduce(
    lambda memo_df, col_name: memo_df.withColumn(col_name, lower(F.col(col_name))),
    source_df.columns,
    source_df
))
```
<br/>
<br/>

### for loop
코드는 못생겼어도, 스파크는 똑똑해서 reduce와 같은 plan을 생성해낸다고 한다. 
```shell
actual_df = source_df

for col_name in actual_df.columns:
    actual_df = actual_df.withColumn(col_name, lower(col(col_name)))
```

<br/>
<br/>

### list comprehension
파이써닉하여 널리 쓰이고 있는 방법이다.
```shell
actual_df = source_df.select(
    *[lower(F.col(col_name)).alias(col_name) for col_name in source_df.columns]
)
```

<br/>
<br/>

## timestamp 연산
<hr/>

## 가장 빈번하게 등장하는 값 찾기
<hr/>

## Window를 사용한 누적합, 랭킹 구하기
<hr/>