package common;

public class Paging {
	// ***** 페이징 변수 ****** 
	// 1.시작 레코드번호 : LIMIT의 시작값
	public int startNum = 0;
	// 2.페이지당 레코드개수 : LIMIT의 개수
	public int onePageCnt = 3;
	// 3.전체 레코드수
	int totalCnt = 0;
	// 4.리스트 그룹수 : 전체개수 ÷ 페이지당개수
	int listGroup = 0;
	// 5.남은 레코드수 : 리스트 그룹에서 남은 레코드수
	int etcRecord = 0;
	// 6.페이징링크 코드 저장변수
	String pgCode = "";
	// 파라미터 형변환 변수(현재 페이지번호)
	public int pageSeq = 1; // 기본값 1(파라미터가 없으면 1들어감!)
	// 한계수 체크: 나머지가 있고 없고에 따라 1개차이남
	int limit; 

	///////////////////////
	// 생성자 메서드 /////////
	// 역할: 인스턴스 생성시 바로 실행하므로 기본 변수값을 모두 셋팅한다!
	public Paging() {
		// DB연결 클래스 생성하기
		JDBConnector jdbc = new JDBConnector();

		/********************************* 
		15. 페이징 링크 생성하기
		______________________________

		1)시작 레코드번호 : startNum
		2)페이지당 레코드개수 : onePageCnt
		3)전체 레코드수 : totalCnt
		4)리스트 그룹수 : listGroup
			(전체개수 ÷ 페이지당개수) 
		5)남은 레코드수 : etcRecord
		6)페이징링크 코드 저장변수 pgCode

		 *********************************/
		try {
			// 15-1. 전체 레코드 수 구하기
			// 레코드수 구하기 쿼리
			String cntQuery = "SELECT COUNT(*) FROM `drama_info`";
			// 쿼리를 PreparedStatement에 넣기
			jdbc.pstmt = jdbc.conn.prepareStatement(cntQuery);
			// 쿼리실행! -> 개수정보를 리턴받아 ResultSet에 담는다!
			jdbc.rs = jdbc.pstmt.executeQuery();

			// 개수결과가 있으면 가져오기
			if (jdbc.rs.next()) {
				totalCnt = jdbc.rs.getInt(1);
				// getInt(1)은 정수형 결과를 가져옴!
			} ////// if ///////////

			// 15-2. 리스트 그룹수 : 전체개수 ÷ 페이지당개수
			listGroup = totalCnt / onePageCnt;

			// 15-3. 남은 레코드수 : 전체개수 % 페이지당개수
			// 나머지 구할땐 %연산자
			etcRecord = totalCnt % onePageCnt;

			// 한계수 체크: 나머지가 있고 없고에 따라 1개차이남
			limit = etcRecord == 0 ? listGroup : listGroup + 1;
			// 나머지가 있으면 1페이지 더 추가!


		} /// try ////
		catch (Exception e) {
			e.printStackTrace();
		} /// catch ////


		// 콘솔에 찍어보기
		System.out.println("# 전체개수:" + totalCnt + "개");
		System.out.println("# 페이지당개수:" + onePageCnt + "개");
		System.out.println("# 리스트 그룹수:" + listGroup + "개");
		System.out.println("# 남은 레코드수:" + etcRecord + "개");

	} /////// 생성자 메서드 ///////

	
	// 사용자 정의 메서드 1
	//////////////////////////////////
	/// 시작번호 구해서 리턴하는 메서드 /////
	/////////////////////////////////
	// 역할: 각 페이지마다 시작번호가 다르므로 이를 구하여 리턴함!
	public int changeStartNum(String pgnum) {
		// pgnum 변수는 리스트 페이지의 파라미터 pgnum을 가져옴!
		// url/.../list.html?pgnum=3 이부분임!
		/**************************************** 
		[ 페이징 변수처리전 페이지번호로 시작번호 변경하기 ]
		 *****************************************/
		// 페이지번호 가져오기
		String pgNum = pgnum;
		System.out.println("파라미터:" + pgNum);


		// 파라미터가 있으면 시작값 처리하기
		if (pgNum != null) { // null이 아니면!
			// 파라미터 형변환!
			try {
				pageSeq = Integer.parseInt(pgNum);
			} catch (NumberFormatException ex) {
				System.out.println("파라미터가 숫자가 아닙니다!<br>");
				// 기본값으로 돌려보낸다!
				pageSeq = 1;
			}
			// 시작번호 계산하기 : 페이지당 레코드수 * (페이지번호-1)
			startNum = onePageCnt * (pageSeq - 1);

		} //////////// if //////////////

		// 시작번호 리턴하기
		return startNum;

	} ///////////// changeStartNum 메서드 //////////

	//// 페이징 소스 리턴 메서드 /////
	public String makePaging() {
		// 15-4. 페이징 링크 코드 만들기
		for (int i = 0; i < limit; i++) {
			// 만약 현재 페이지와 같은 번호는 a링크 걸지말고
			// b태그로 두꺼운 글자 표시만 해주자!
			if (i == pageSeq - 1) { // i는 0부터니까 1뺌
				pgCode += "<b>" + (i + 1) + "</b>";
			} /// if ////
			else {
				// pgCode변수에 모두 넣는다
				pgCode += "<a href='list.jsp?pgnum=" + (i + 1) + "'>" + (i + 1) + "</a>";
			} /// else //////

			// 사이바 찍기 
			// (한계값-1,즉 마지막번호 전까지만 사이바출력)
			if (i < limit - 1) {
				pgCode += " | ";
			}

		} ////////// for //////////////
		
		// 최종 결과 리턴하기!!!
		return pgCode;
		
	} ////////// makePaging 메서드 //////////





} ///////// 클래스 //////////
