package com.board;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

//DAO
public class BoardDAO {

	// 
	private Connection conn;

	public BoardDAO(Connection conn) {
		this.conn = conn;
	}

	// 
	public int getMaxNum() {

		int maxNum = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			// 
			sql = "select max(num) from board";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				maxNum = rs.getInt(1); //
				// 
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return maxNum;

	}

	// 
	public int insertData(BoardDTO dto) {

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "insert into board (name,pwd,email,subject,";
			sql += "content,ipAddr,hitCount) ";
			sql += "values (?,?,?,?,?,?,0)";

			pstmt = conn.prepareStatement(sql);

			// 
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getIpAddr());

			result = pstmt.executeUpdate(); // 

			pstmt.close();//

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result; //
		//

	}

	//
	public int getDataCount(String searchKey, String searchValue) {

	int totalCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			searchValue = "%" + searchValue + "%";
			
			sql = "select count(*) from board ";
			sql+= "where " + searchKey + " like ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchValue);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return totalCount;
	}

	// 
	public List<BoardDTO> getLists(int start, int end,String searchKey, String searchValue) {
	

		List<BoardDTO> lists = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			
			searchValue = "%" + searchValue + "%";
			
			
			sql= "select num,name,subject,hitcount,created";
			sql+= " from board";
			if(searchValue!="") { // 검색어가 있을때만 like구문 넣기
				sql+= " where " + searchKey + " like " + searchValue;				
			}
			sql+= " order by num desc" ;
			sql+= " limit ?, ?";
			
			System.out.println(sql+"/"+start+"/"+end);
			pstmt = conn.prepareStatement(sql);
			
//			pstmt.setString(1, searchValue);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				lists.add(dto);
			}
			
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return lists;
		
		
	}
	

	
	
	
	// 
	public BoardDTO getReadData(int num) {

		BoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select num,name,pwd,email,subject,content,";
			sql += "ipAddr,hitCount,created ";
			sql += "from board where num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) { //

				dto = new BoardDTO();// 

				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setIpAddr(rs.getString("ipAddr"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}

	// 
	public int updateHitCount(int num) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "update board set hitCount=hitCount+1 where num=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}
	
	
	//
	public int updateData(BoardDTO dto) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update board set name=?,pwd=?,email=?,subject=?,";
			sql+= "content=? where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getPwd());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6, dto.getNum());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	//
	public int deleteData(int num) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete board where num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}

}
