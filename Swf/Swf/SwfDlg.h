// SwfDlg.h : 头文件
//

#pragma once


// CSwfDlg 对话框
class CSwfDlg : public CDialog
{
// 构造
public:
	CSwfDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_SWF_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
private:
	CString m_FileName;

protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedOpen1();
	afx_msg void OnBnClickedOpen2();
	afx_msg void OnBnClickedDowork();
};
