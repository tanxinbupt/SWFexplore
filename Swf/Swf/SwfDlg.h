// SwfDlg.h : ͷ�ļ�
//

#pragma once


// CSwfDlg �Ի���
class CSwfDlg : public CDialog
{
// ����
public:
	CSwfDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_SWF_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��


// ʵ��
private:
	CString m_FileName;

protected:
	HICON m_hIcon;

	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedOpen1();
	afx_msg void OnBnClickedOpen2();
	afx_msg void OnBnClickedDowork();
};
