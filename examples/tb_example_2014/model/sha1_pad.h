#ifdef __cplusplus
	#define DPI_LINK_DECL  extern "C" 
#else
	#define DPI_LINK_DECL 
#endif

#include "svdpi.h"

//Get message which need to be expanded and take an extended message
DPI_LINK_DECL DPI_DLLESPEC void sha1_align(svBitVecVal ext[64],const char* mes);
