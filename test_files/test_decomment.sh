#!/bin/bash

# 색상 정의 (가독성용)
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "------------------------------------------------"
echo " Decommenter Automated Test Start (test0 ~ test5)"
echo "------------------------------------------------"

# 테스트 케이스 0부터 5까지 반복
for i in {0..5}
do
    TEST_FILE="test$i.c"
    
    # 테스트 파일 존재 여부 확인
    if [ ! -f "$TEST_FILE" ]; then
        echo -e "File $TEST_FILE not found, skipping..."
        continue
    fi

    echo -n "Testing $TEST_FILE... "

    # 1. 샘플 실행파일(정답) 실행
    ./sampledecomment < "$TEST_FILE" > output1 2> errors1
    
    # 2. 내가 만든 실행파일 실행
    ./decomment < "$TEST_FILE" > output2 2> errors2

    # 3. 표준 출력(Stdout) 비교
    STDOUT_DIFF=$(diff -c output1 output2)
    
    # 4. 표준 에러(Stderr) 비교
    STDERR_DIFF=$(diff -c errors1 errors2)

    # 5. 결과 확인
    if [ -z "$STDOUT_DIFF" ] && [ -z "$STDERR_DIFF" ]; then
        echo -e "${GREEN}PASSED${NC}"
    else
        echo -e "${RED}FAILED${NC}"
        if [ ! -z "$STDOUT_DIFF" ]; then
            echo "[STDOUT DIFFERENCE]"
            echo "$STDOUT_DIFF"
        fi
        if [ ! -z "$STDERR_DIFF" ]; then
            echo "[STDERR DIFFERENCE]"
            echo "$STDERR_DIFF"
        fi
    fi

    # 임시 파일 삭제
    rm -f output1 output2 errors1 errors2
done

echo "------------------------------------------------"
echo " Test Completed."
