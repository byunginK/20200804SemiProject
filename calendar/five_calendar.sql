CREATE TABLE FIVE_CALENDAR(
	SEQ NUMBER(8) PRIMARY KEY,
	CONTENTS VARCHAR2(200),
	CALDATE VARCHAR2(50)
)

CREATE SEQUENCE FIVE_CAL_SEQ
START WITH 1
INCREMENT BY 1


INSERT INTO FIVE_CALENDAR VALUES(FIVE_CAL_SEQ.NEXTVAL, 'test','20200701')
INSERT INTO FIVE_CALENDAR VALUES(FIVE_CAL_SEQ.NEXTVAL, 'test1','20200701')
INSERT INTO FIVE_CALENDAR VALUES(FIVE_CAL_SEQ.NEXTVAL, 'test','20200715')
INSERT INTO FIVE_CALENDAR VALUES(FIVE_CAL_SEQ.NEXTVAL, 'test','20200716')
INSERT INTO FIVE_CALENDAR VALUES(FIVE_CAL_SEQ.NEXTVAL, 'test','20200723')


SELECT SEQ, CONTENTS,CALDATE 
FROM FIVE_CALENDAR 
WHERE CALDATE = '20200701' 
ORDER BY SEQ DESC

DELETE FROM FIVE_CALENDAR WHERE SEQ = 6

SELECT *
FROM FIVE_INFO

SELECT *
FROM USER_SEQUENCES

SEQ_FIVE_INFO

INSERT INTO FIVE_INFO VALUES(SEQ_FIVE_INFO.NEXTVAL,'a','test1','테스트를 한번 해보겠습니다',sysdate)
INSERT INTO FIVE_INFO VALUES(SEQ_FIVE_INFO.NEXTVAL,'a','test2','테스트를 한번 해보겠습니다',sysdate)
INSERT INTO FIVE_INFO VALUES(SEQ_FIVE_INFO.NEXTVAL,'a','test3','테스트를 한번 해보겠습니다',sysdate)
INSERT INTO FIVE_INFO VALUES(SEQ_FIVE_INFO.NEXTVAL,'aaa','test4','라틴어로 기병을 의미한다. 고대 로마의 원로원 계급 다음가는 신분이다. 원래는 말에 타고 군무에 종사하는 사람을 의미하였기에 이런 이름이 붙었으나, 점차 일정한 재산과 자격을 구비한 사람이 이 계층에 들게 되고 그것이 세습신분화 되어 로마사회의 하급 지배계층으로 굳어지게 된다. 초기 로마 왕국의 군사제도에서는 병사 자신의 재산으로 무장을 구입해야 했기 때문에 말을 사서 무장할 수 있을 정도의 재산가만이 에퀴테스가 될 수 있었다. 후에 군제 개편에 의해 로마가 직업군인제로 바뀌면서 기병이라는 의미보다는 큰 재산을 지닌 사회적 지배계급으로서의 의미가 강해지게 되는데, 사실 그 이전부터 군대의 규모가 커짐에 따라 에퀴테스가 아닌 일반 부유평민들이 기병으로 대거 들어오면서 기병으로서의 정체성이 많이 흐려지게 된 반면, 군대 내 여러 장교직들을 거의 배타적으로 맡게되는등 아래 평민신분들과는 차별화된 우대를 받았으며 이외에도 사회적으로는 상업이나 광업등의 사업을 대규모로 운영하며 큰 부를 축적했기 때문이다. 또한 에퀴테스들은 자신들의 튜닉에 좁은 띠로 자수를 놓아 신분을 표시할 수 있었데, 이것이 로마군내 장교보직의 명칭에 반영되기도 하였다',sysdate)


