// CircuitLoaderDlg.h : header file
//
//{{AFX_INCLUDES()
#include "rpcox.h"
#include "commondialog.h"
//}}AFX_INCLUDES

#if !defined(AFX_CIRCUITLOADERDLG_H__39ECF7E3_691A_4DA8_B69B_DEC09EDD2643__INCLUDED_)
#define AFX_CIRCUITLOADERDLG_H__39ECF7E3_691A_4DA8_B69B_DEC09EDD2643__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CCircuitLoaderDlg dialog

class CCircuitLoaderDlg : public CDialog
{
// Construction
public:
	CCircuitLoaderDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CCircuitLoaderDlg)
	enum { IDD = IDD_CIRCUITLOADER_DIALOG };
	CButton	m_load_button;
	CButton	m_cancel_button;
	int		m_radio_interface;
	int		m_radio_rp;
	CString	m_devnum_text;
	CRPcoX	m_ra16_1;
	CRPcoX	m_ra16_2;
	CRPcoX	m_ra16_3;
	CRPcoX	m_ra16_4;
	CRPcoX	m_ra16_5;
	CRPcoX	m_ra16_6;
	CRPcoX	m_ra16_7;
	CRPcoX	m_ra16_8;
	CRPcoX	m_rl2_1;
	CRPcoX	m_rl2_2;
	CRPcoX	m_rl2_3;
	CRPcoX	m_rl2_4;
	CRPcoX	m_rl2_5;
	CRPcoX	m_rl2_6;
	CRPcoX	m_rl2_7;
	CRPcoX	m_rl2_8;
	CRPcoX	m_rp2_1;
	CRPcoX	m_rp2_2;
	CRPcoX	m_rp2_3;
	CRPcoX	m_rp2_4;
	CRPcoX	m_rp2_5;
	CRPcoX	m_rp2_6;
	CRPcoX	m_rp2_7;
	CRPcoX	m_rp2_8;
	CRPcoX	m_rv8_1;
	CRPcoX	m_rv8_2;
	CRPcoX	m_rv8_3;
	CRPcoX	m_rv8_4;
	CRPcoX	m_rv8_5;
	CRPcoX	m_rv8_6;
	CRPcoX	m_rv8_7;
	CRPcoX	m_rv8_8;
	CCommonDialog1	m_openfile_dialog;
	CString	m_status_label;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCircuitLoaderDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CCircuitLoaderDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg CRPcoX& GetRP(CString devtype, int devnum);
	afx_msg long RunCircuit(CRPcoX &rp, CString filepath, CString devtype, CString inter, int devnum);
	afx_msg void OnLoadClick();
	afx_msg void OnCancelClick();
	afx_msg void OnChangeDevnum();
	afx_msg void HaltAll();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CIRCUITLOADERDLG_H__39ECF7E3_691A_4DA8_B69B_DEC09EDD2643__INCLUDED_)
