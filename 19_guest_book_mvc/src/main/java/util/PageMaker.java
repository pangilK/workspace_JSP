package util;

public class PageMaker {
	
	Criteria cri;	// 현재 요청 페이지 및 한 페이지에 보여줄 게시글 개수
	
	private int totalCount; 	// 전체 게시물의 개수
	private int displayPageNum; // 한 페이지 블럭에 보여줄 페이지 번호 수
	private int maxPage;		// 최대 페이지 수 - 번호
	private int startPage;		// 시작 페이지 번호
	private int endPage;		// 현재 페이지 블럭에서 보여줄 마지막 페이지 번호
	private boolean prev;		// 이전페이지 블럭 존재 여부
	private boolean next;		// 다음페이지 블럭 존재 여부
	
	public PageMaker() {
		this.cri = new Criteria();
		this.displayPageNum = 5;
	}
	
	public void calcPaging() {
		// paging 정보 출력에 필요한 필드 연산
		//					1			/ 			5.0  ==  0.2(1) 	* 	5 = 5
		//					5			/			5.0  ==	 1.0(1)		*   5 = 5
		//					6			/ 			5.0  ==  1.2(2) 	*   5 = 10
		endPage = (int)Math.ceil(cri.getPage() / (double)displayPageNum)*displayPageNum;
		startPage = (endPage - displayPageNum) + 1;
		// 140 / 10 = 14.0 (14) == 14page
		// 141 / 10 = 14.1 (15) == 15page
		maxPage = (int)Math.ceil(totalCount / (double) cri.getPerPageNum());
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		prev = (startPage != 1) ? true : false;
		next = (endPage == maxPage) ?  false : true;
	}
	

	public int getMaxPage() {
		return maxPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public boolean isNext() {
		return next;
	}
	public Criteria getCri() {
		return cri;
	}
	public void setCri(Criteria cri) {
		this.cri = cri;
		calcPaging();
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPaging();
	}
	
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
		calcPaging();
	}
	
	@Override
	public String toString() {
		return "PageMaker [cri=" + cri + ", totalCount=" + totalCount + ", displayPageNum=" + displayPageNum
				+ ", maxPage=" + maxPage + ", startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev
				+ ", next=" + next + "]";
	}
	
}
