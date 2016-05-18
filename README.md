#Step by step

1 Singleview app

2 Create new targets (CocoaTouchFramework) dynamic-library-1 & dynamic-library-2

3 Create 2 CASHello classes

4 Add each CASHello class to each dynamic lib target in `compile sources`


###Make the frameworks not link on startup

5 Remove frameworks from app target `General` page

6 #import "dlfcn.h"

7 Add both frameworks as target dependencies to app (to make them build)

8 Add a new `Copy Files` build phase configured for `Frameworks` destination

8 Add both frameworks to the new `Copy Files` Build Phase to have them packed and signed together with your app