// CircuitLoader.h : main header file for the CIRCUITLOADER application
//

#if !defined(AFX_CIRCUITLOADER_H__C41D2171_B9E0_46D1_BCBC_1C6378DF98AF__INCLUDED_)
#define AFX_CIRCUITLOADER_H__C41D2171_B9E0_46D1_BCBC_1C6378DF98AF__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CCircuitLoaderApp:
// See CircuitLoader.cpp for the implementation of this class
//

class CCircuitLoaderApp : public CWinApp
{
public:
	CCircuitLoaderApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCircuitLoaderApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CCircuitLoaderApp)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CIRCUITLOADER_H__C41D2171_B9E0_46D1_BCBC_1C6378DF98AF__INCLUDED_)
