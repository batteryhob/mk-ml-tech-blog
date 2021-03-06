---
layout: post
title: Facial Expression 기반의 게임 경험 평가
date: 2021-05-26 00:00:00 +0900
author: 권승진
tags: computervision
excerpt: Facial Expression 기반의 게임 경험 평가
use_math: false
toc: true
# tags: 자동 수집되는 태그 띄어쓰기로 구분, 반드시 소문자로 사용
# excerpt: 메인 화면에 노출되는 post의 description
# use_math : 수식이 필요 할 경우(윗 첨자, 아랫첨자 동시 사용 불가) true | false
# toc : 목차가 필요 할 경우 true | false
# emoji 사이트: https://getemoji.com/
---

## Introduction
최근 저희가 만든 nxFGT 얼굴 분석 엔진을 이용한 테스트가 진행되었습니다.   
가장 큰 목적은 게임을 플레이하면서 게임 테스터는 어떤 감정들을 얼굴로 표현할까? 에 초점을 맞춰진 테스트입니다. 그 감정의 변화가 일어나는 특별한 순간들을 캐치하고, 분석하는 것이 이 프로젝트의 목적입니다.  
이 테스트는 다음과 같은 15개의 게임 세션으로 구성되었습니다.  

| 이름 | 세션수 | 플레이타임 |
|---|:---:|---:|
|FIFA Online 4| 3 | 약 25분 |
|플레이투게더| 2 | 약 35분 |
|It takes two| 1 | 약 82분 |
|타이탄폴2| 1 | 약 35분 |
|서든어택| 2 | 약 12분 |
|클래시로얄| 1 | 약 4분 |
|ALTF4| 1 | 약 8분 |
|오버워치| 1 | 약 8분 |
|리그 오브 레전드| 1 | 약 22분 |
|던전 앤 파이터| 2 | 약 10분 |
|카트라이더| 29 | 약 77분 |

<br/>

## 카운팅
기본적으로 사람이 컴퓨터 앞에 앉았을 때는 무표정입니다. 그리고 게임 속 어떤 변화가 일어날때마다 사람은 웃거나, 화를 내거나 하는 특별한 감정이 얼굴로 나타납니다.
집계된 감정을 카운트로 보면 다음과 같습니다.  

| 이름 | 세션수 | 플레이타임 | 긍정반응 | 부정반응
|---|:---:|---:|---:|---:|
|FIFA Online 4| 3 | 약 25분 | 2 | 0
|플레이투게더| 2 | 약 35분 | 59 | 2
|It takes two| 1 | 약 82분 | 3980 | 75 
|타이탄폴2| 1 | 약 35분 | 6 | 0
|서든어택| 2 | 약 12분 | 135 | 3
|클래시로얄| 1 | 약 4분 | 0 | 0
|ALTF4| 1 | 약 8분 | 3 | 11
|오버워치| 1 | 약 8분 | 0 | 0
|리그 오브 레전드| 1 | 약 22분 | 64 | 3
|던전 앤 파이터| 2 | 약 10분 | 95 | 0
|카트라이더| 29 | 약 77분 | 3770 | 42


Stacked Bar Chart로 본 표입니다.
![Stacked Bar Chart](https://solution-userstats.s3.amazonaws.com/techblogs/seungjin/2021-05-26-FE/1.png)

플레이타임이 긴 It takes two, 카트라이더를 빼고 본 표입니다.
![Stacked Bar Chart2](https://solution-userstats.s3.amazonaws.com/techblogs/seungjin/2021-05-26-FE/2.png)

이를 통해 감정의 발생량과 각각 긍정, 부정량을 파악할 수 있습니다. 

## 카트라이더 감정 발생 비율
카트라이더의 경우가 장르 특성상 가장 다양한 감정이 발생했기 때문에 각각 감정의 발생량을 비율로 표현해봤습니다.  

![Stacked Bar Chart2](https://solution-userstats.s3.amazonaws.com/techblogs/seungjin/2021-05-26-FE/3.png)


## 세션별 시계열 누적
게임 세션에서 시간이 흐름에 따라 감정량이 어떻게 누적되어가는지를 추적하는 그래프입니다.
세션의 초반, 중반, 후반 중 어디서 집중적으로 테스트 참가자의 감정 변화가 발생했는지 알 수 있습니다.  
![Acc Chart](https://solution-userstats.s3.amazonaws.com/techblogs/seungjin/2021-05-26-FE/4.png)


## 대표 감정
특정 게임마다 많이 일어나는 감정이 각각 다른지를 분석해봤습니다. 현재는 테스트라 숫자가 적지만, 차후 대량 플레이 데이터 삽입 시 특정 게임마다, 특정 게임의 구간마다 대표 반응을 알 수 있는 메트릭이 될 것입니다. 
현재는 게임 타이틀로 구분하여 나타냈습니다.  

| 이름 | 대표 반응
|---|:---:|
|FIFA Online 4| 웃음
|플레이투게더| 웃음
|It takes two| 웃음
|타이탄폴2| 웃음
|서든어택| 웃음
|클래시로얄| 무표정
|ALTF4| 화남
|오버워치| 무표정
|리그 오브 레전드| 웃음
|던전 앤 파이터| 웃음
|카트라이더| 웃음

ALTF4의 경우가 특이한데, 실제로 유저를 열받게 하면서 몰입하게 만든다는 평가를 받는 게임입니다. 육안 분석결과도 해당 플레이동안 테스트 참가자가 자주 화내는 모습을 관찰할 수 있었습니다.
참조:[나무위키 ALTF4](https://namu.wiki/w/ALTF4)  

## 결론
이번 테스트로 게임 테스트 시 얼굴에서 발생하는 감정을 어떤 식으로 가공할 것인지에 대해 많은 고민을 해볼 수 있었습니다. 적은 량이지만 게임의 특성과 사용자의 감정 반응의 연관성을 발견할 수도 있었습니다. 현재는 게임을 카테고리로 묶어서 결과를 냈지만 테스트 세션의 수가 늘어날수록, 각 게임에서도 세부 구간별로 특성을 정의하여 결과를 도출할수 있다고 생각됩니다. 
