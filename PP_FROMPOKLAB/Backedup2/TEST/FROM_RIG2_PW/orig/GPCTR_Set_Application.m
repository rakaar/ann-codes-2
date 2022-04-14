function varargout = GPCTR_Set_Application(varargin)
%GPCTR_SET_APPLICATION calls NI library with the appropriate arguments.
%
% The C declaration for this function is the following:
%	  extern i16 _stdcall GPCTR_Set_Application ( i16 deviceNumber, u32 gpCounterNumber, u32 application); 
%
% The MATLAB Declaration looks like the following:
%	int16 GPCTR_Set_Application(int16, uint32, uint32)
%
% This function will call loadlibrary on the library if needed.
% This file is automatically generated by the loadlibrarygui.
%
%   See also
%   LOADLIBRARY, UNLOADLIBRARY, LOADNI, UNLOADNI

%
%
% $Author: $
% $Revision: $
% $Date: 12-Feb-2004 10:05:04 $
%
% Local Functions Defined:
%
%
% $Notes:
%
%
%
%
% $EndNotes
%
% $Description:
%
%
%
%
% $EndDescription


if nargin==0;
	help(mfilename);
	return;
end;


% If Library is loaded already unload it.

if ~libisloaded('NI')
	loadNI;
end;


if nargin~=3;
	error(mfilename:WrongNumberIn,'Incorrect number of input arguments.');
end;

% if nargout~=1;
% 	error(mfilename:WrongNumberOut,'Incorrect number of output arguments.');
% end;

% Call external function in loaded DLL.
[varargout{1}]=calllib('NI','GPCTR_Set_Application',varargin{:});

