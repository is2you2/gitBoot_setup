ssh-add ~/.ssh/*.pem
while :
do
    clear
    echo ""
    cat<<EOF
    ======================================
                 Git 저장소 작업
    --------------------------------------
    작업 번호를 입력해주세요 :

    1) 저장소에 새 프로젝트를 등록하기
    2) 저장소에서 기존 프로젝트를 가져오기
        q)uit - 나가기
    --------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")  echo ""
    echo "새 프로젝트를 등록할 예정입니다."
    echo ""
    ls
    echo ""
    read -e -p "등록할 프로젝트 폴더 이름을 적어주세요. (대소문자 구분 필요해요) : " NAME
    if [$NAME == ""];
    then
    echo ""
    echo "이름 자리에 공란이 되면 안되어요 ... !"
    echo ""
    exit
    fi
    echo ""
    echo "   업로드할 프로젝트 폴더 이름은 $NAME"
    echo "* 업로드 진행 중에 파일 수정을 하거나 이 터미널을 종료하면 곤란해요!"
    sleep 5
    echo ""
    echo "업로드 작업 시작!"
    zip $NAME $NAME/*
    scp $NAME.zip ubuntu@0.0.0.0:
    rm $NAME.zip
    mv $NAME $NAME-orig
    ssh ubuntu@0.0.0.0 ./autogit.sh
    echo ""
    echo ""
    echo "업로드 작업 끝!"
    echo ""
    echo "해당 프로젝트를 서버에 연결시킵니다.."
    echo ""
    git clone ubuntu@0.0.0.0:$NAME
    mv $NAME-orig/.gitignore $NAME/.gitignore
    cd $NAME
    git rm -rf --cached .
    git add .
    git commit -m "gitIgore apply autoCommit"
    git push
    cd ..
    echo ""
    echo "서버측 폴더 확인:"
    ssh ubuntu@0.0.0.0 ls -l | grep $NAME
    echo ""
    echo "서버에 정상적으로 업로드 되었습니다 :D"
    echo ""
    ls -l | grep $NAME
    echo ""
    echo "혹시 몰라 백업을 두었으니 확인하세요~"
    echo ""
    exit
    ;;
    "2")  echo ""
    echo "저장소에서 기존 프로젝트를 가져올 예정입니다."
    ssh ubuntu@0.0.0.0 ls
    echo ""
    read -e -p "불러올 프로젝트의 이름을 적어주세요. (대소문자 구분 필요해요) : " NAME
    if [$NAME == ""];
    then
    echo ""
    echo "이름 자리에 공란이 되면 안되어요 ... !"
    echo ""
    exit
    fi
    echo ""
    echo "가져올 프로젝트의 이름은 $NAME"
    sleep 1
    echo ""
    ssh ubuntu@0.0.0.0 git config --global pack.windowMemory 256m
    git clone ubuntu@0.0.0.0:$NAME
    echo ""
    echo "프로젝트 불러오기 끝!"
    echo ""
    echo "불러온 프로젝트의 위치 확인:"
    echo ""
    pwd
    ls -l | grep $NAME
    echo ""
    echo "확인해주세요. :)"
    echo ""
    exit  ;;
    "q")  echo ""
    echo "오늘 하루도 화이팅! :)"
    echo ""
    exit   ;; 
     * )  echo ""
     echo "이거 말구요~!: $REPLY"     ;;
    esac
    sleep 1
done
