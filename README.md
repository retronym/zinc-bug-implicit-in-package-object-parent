## Incremental compilation bug in Zinc/SBT with package object with parent containing inner class

```diff
diff -u src/main/scala/p1/O1.scala src/main-changes/scala/p1/O1.scala
--- src/main/scala/p1/O1.scala	2021-06-03 17:07:36.000000000 +1000
+++ src/main-changes/scala/p1/O1.scala	2021-06-03 16:56:55.000000000 +1000
@@ -1,5 +1,5 @@
 package p1

 object O1 {
-  def o1 = ""
+  def o1 = 42
 }
```

```
./build.sh
+ sbt compile
[info] [launcher] getting org.scala-sbt sbt 1.5.4-SNAPSHOT  (this may take some time)...
[info] welcome to sbt 1.5.4-SNAPSHOT (AdoptOpenJDK Java 1.8.0_272)
[info] loading global plugins from /Users/jz/.sbt/1.0/plugins
[info] compiling 1 Scala source to /Users/jz/.sbt/1.0/plugins/target/scala-2.12/sbt-1.0/classes ...
[info] Non-compiled module 'compiler-bridge_2.12' for Scala 2.12.14. Compiling...
[info]   Compilation completed in 8.105s.
[info] loading project definition from /Users/jz/code/zinc-bug-implicit-in-package-object-parent/project
[info] loading settings for project zinc-bug-implicit-in-package-object-parent from build.sbt ...
[info] set current project to zinc-bug-implicit-in-package-object-parent (in build file:/Users/jz/code/zinc-bug-implicit-in-package-object-parent/)
[info] Executing in batch mode. For better performance use sbt's shell
[success] Total time: 0 s, completed 03/06/2021 11:31:37 PM
+ cp -R src/main-changes/scala src/main/
+ sbt debug compile
[info] welcome to sbt 1.5.4-SNAPSHOT (AdoptOpenJDK Java 1.8.0_272)
[info] loading global plugins from /Users/jz/.sbt/1.0/plugins
[info] loading project definition from /Users/jz/code/zinc-bug-implicit-in-package-object-parent/project
[info] loading settings for project zinc-bug-implicit-in-package-object-parent from build.sbt ...
[info] set current project to zinc-bug-implicit-in-package-object-parent (in build file:/Users/jz/code/zinc-bug-implicit-in-package-object-parent/)
[info] Executing in batch mode. For better performance use sbt's shell
[debug] not up to date. inChanged = true, force = false
[debug] Updating ...
[debug] Done updating
[debug] [zinc] IncrementalCompile -----------
[debug] IncrementalCompile.incrementalCompile
[debug] previous = Stamps for: 6 products, 3 sources, 1 libraries
[debug] current source = Set(${BASE}/src/main/scala/p1/T1.scala, ${BASE}/src/main/scala/p1/O1.scala, ${BASE}/src/main/scala/p1/package.scala)
[debug] > initialChanges = InitialChanges(Changes(added = Set(), removed = Set(), changed = Set(${BASE}/src/main/scala/p1/O1.scala), unmodified = ...),Set(),Set(),API Changes: Set())
[debug]
[debug] Initial source changes:
[debug] 	removed: Set()
[debug] 	added: Set()
[debug] 	modified: Set(${BASE}/src/main/scala/p1/O1.scala)
[debug] Invalidated products: Set()
[debug] External API changes: API Changes: Set()
[debug] Modified binary dependencies: Set()
[debug] Initial directly invalidated classes: Set(p1.O1)
[debug] Sources indirectly invalidated by:
[debug] 	product: Set()
[debug] 	binary dep: Set()
[debug] 	external source: Set()
[debug] All initially invalidated classes: Set(p1.O1)
[debug] All initially invalidated sources:Set(${BASE}/src/main/scala/p1/O1.scala)
[debug] Created transactional ClassFileManager with tempDir = /Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes.bak
[debug] [inv] Invalidate package objects by inheritance only...
[debug] Initial set of included nodes: p1.O1
[debug] [inv] Package object invalidations:
[debug] About to delete class files:
[debug] 	O1.class
[debug] 	O1$.class
[debug] We backup class files:
[debug] 	O1.class
[debug] 	O1$.class
[debug] [inv] ********* Pruned:
[debug] [inv] Relations:
[debug] [inv]   products: Relation [
[debug] [inv]     ${BASE}/src/main/scala/p1/T1.scala -> ${BASE}/target/scala-2.12/classes/p1/T1$C.class
[debug] [inv]     ${BASE}/src/main/scala/p1/T1.scala -> ${BASE}/target/scala-2.12/classes/p1/T1.class
[debug] [inv]     ${BASE}/src/main/scala/p1/package.scala -> ${BASE}/target/scala-2.12/classes/p1/package$.class
[debug] [inv]     ${BASE}/src/main/scala/p1/package.scala -> ${BASE}/target/scala-2.12/classes/p1/package.class
[debug] [inv] ]
[debug] [inv]   library deps: Relation [
[debug] [inv]     ${BASE}/src/main/scala/p1/T1.scala -> ${SBT_BOOT}/scala-2.12.14/lib/scala-library.jar
[debug] [inv] ]
[debug] [inv]   library class names: Relation [
[debug] [inv]     ${SBT_BOOT}/scala-2.12.14/lib/scala-library.jar -> scala.Int
[debug] [inv]     ${SBT_BOOT}/scala-2.12.14/lib/scala-library.jar -> scala.Unit
[debug] [inv] ]
[debug] [inv]   internalDependencies:
[debug] [inv]     DependencyByMemberRef Relation [
[debug] [inv]     p1.T1.C -> p1.O1
[debug] [inv]     p1.package -> p1.T1
[debug] [inv] ]
[debug] [inv]     DependencyByInheritance Relation [
[debug] [inv]     p1.package -> p1.T1
[debug] [inv] ]
[debug] [inv]   externalDependencies:
[debug] [inv]   class names: Relation [
[debug] [inv]     ${BASE}/src/main/scala/p1/T1.scala -> p1.T1
[debug] [inv]     ${BASE}/src/main/scala/p1/T1.scala -> p1.T1.C
[debug] [inv]     ${BASE}/src/main/scala/p1/package.scala -> p1.package
[debug] [inv] ]
[debug] [inv]   used names: Relation [
[debug] [inv]     p1.T1 -> UsedName(AnyRef,[Default])
[debug] [inv]     p1.T1 -> UsedName(Object,[Default])
[debug] [inv]     p1.T1 -> UsedName(p1,[Default])
[debug] [inv]     p1.T1 -> UsedName(scala,[Default])
[debug] [inv]     p1.T1.C -> UsedName(AnyRef,[Default])
[debug] [inv]     p1.T1.C -> UsedName(C,[Default])
[debug] [inv]     p1.T1.C -> UsedName(O1,[Default])
[debug] [inv]     p1.T1.C -> UsedName(Object,[Default])
[debug] [inv]     p1.T1.C -> UsedName(String,[Default])
[debug] [inv]     p1.T1.C -> UsedName(T1,[Default])
[debug] [inv]     p1.T1.C -> UsedName(java;lang;Object;init;,[Default])
[debug] [inv]     p1.T1.C -> UsedName(o1,[Default])
[debug] [inv]     p1.T1.C -> UsedName(scala,[Default])
[debug] [inv]     p1.package -> UsedName(Object,[Default])
[debug] [inv]     p1.package -> UsedName(T1,[Default])
[debug] [inv]     p1.package -> UsedName(java;lang;Object;init;,[Default])
[debug] [inv]     p1.package -> UsedName(p1,[Default])
[debug] [inv]     p1.package -> UsedName(package,[Default])
[debug] [inv] ]
[debug] [inv]   product class names: Relation [
[debug] [inv]     p1.T1 -> p1.T1
[debug] [inv]     p1.T1.C -> p1.T1$C
[debug] [inv]     p1.package -> p1.package
[debug] [inv]     p1.package -> p1.package$
[debug] [inv] ]
[debug] [inv] *********
[debug] compilation cycle 1
[info] compiling 1 Scala source to /Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes ...
[debug] Getting org.scala-sbt:compiler-bridge_2.12:1.4.0-SNAPSHOT:compile for Scala 2.12.14
[debug] [zinc] Running cached compiler 29a06bd8 for Scala compiler version 2.12.14
[debug] [zinc] The Scala compiler is invoked with:
[debug] 	-bootclasspath
[debug] 	/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/resources.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/rt.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/sunrsasign.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/jsse.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/jce.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/charsets.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/jfr.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/classes:/Users/jz/.sbt/boot/scala-2.12.14/lib/scala-library.jar
[debug] 	-classpath
[debug] 	/Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes
[debug] [inv]
[debug] [inv] Changes:
[debug] [inv] API Changes: Set(NamesChange(p1.O1,ModifiedNames(changes = UsedName(o1,[Default]))))
[debug] Invalidating (transitively) by inheritance from p1.O1...
[debug] Initial set of included nodes: p1.O1
[debug] Invalidated by transitive inheritance dependency: Set(p1.O1)
[debug] The following modified names cause invalidation of p1.T1.C: Set(UsedName(o1,[Default]))
[debug] Change NamesChange(p1.O1,ModifiedNames(changes = UsedName(o1,[Default]))) invalidates 2 classes due to The p1.O1 has the following regular definitions changed:
[debug] 	UsedName(o1,[Default]).
[debug]   > by transitive inheritance: Set(p1.O1)
[debug]   >
[debug]   > by member reference: Set(p1.T1.C)
[debug]
[debug] New invalidations:
[debug] 	p1.T1.C
[debug] Initial set of included nodes: p1.T1.C
[debug] Previously invalidated, but (transitively) depend on new invalidations:
[debug] Final step, transitive dependencies:
[debug] 	Set(p1.T1.C)
[debug] Invalidated classes: p1.T1.C
[debug] Scala compilation took 2.391197397 s
[debug] done compiling
[debug] Registering generated classes:
[debug] 	O1$.class
[debug] 	O1.class
[debug] [inv] Invalidate package objects by inheritance only...
[debug] Initial set of included nodes: p1.T1, p1.T1.C
[debug] Including p1.package by p1.T1
[debug] [inv] Package object invalidations: p1.package
[debug] Recompiling all sources: number of invalidated sources > 50.0% of all sources
[debug] About to delete class files:
[debug] 	package$.class
[debug] 	package.class
[debug] 	O1.class
[debug] 	T1$C.class
[debug] 	O1$.class
[debug] 	T1.class
[debug] We backup class files:
[debug] 	package$.class
[debug] 	package.class
[debug] 	T1$C.class
[debug] 	T1.class
[debug] [inv] ********* Pruned:
[debug] [inv] Relations:
[debug] [inv]   products: Relation [ ]
[debug] [inv]   library deps: Relation [ ]
[debug] [inv]   library class names: Relation [
[debug] [inv]     ${SBT_BOOT}/scala-2.12.14/lib/scala-library.jar -> scala.Int
[debug] [inv]     ${SBT_BOOT}/scala-2.12.14/lib/scala-library.jar -> scala.Unit
[debug] [inv] ]
[debug] [inv]   internalDependencies:
[debug] [inv]   externalDependencies:
[debug] [inv]   class names: Relation [ ]
[debug] [inv]   used names: Relation [ ]
[debug] [inv]   product class names: Relation [ ]
[debug] [inv] *********
[debug] compilation cycle 2
[info] compiling 3 Scala sources to /Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes ...
[debug] Getting org.scala-sbt:compiler-bridge_2.12:1.4.0-SNAPSHOT:compile for Scala 2.12.14
[debug] [zinc] Running cached compiler d35a8b2 for Scala compiler version 2.12.14
[debug] [zinc] The Scala compiler is invoked with:
[debug] 	-bootclasspath
[debug] 	/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/resources.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/rt.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/sunrsasign.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/jsse.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/jce.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/charsets.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/jfr.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/classes:/Users/jz/.sbt/boot/scala-2.12.14/lib/scala-library.jar
[debug] 	-classpath
[debug] 	/Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes
[debug] [inv]
[debug] [inv] Changes:
[debug] [inv] API Changes: Set()
[debug] Scala compilation took 0.323404628 s
[debug] done compiling
[debug] Registering generated classes:
[debug] 	package$.class
[debug] 	package.class
[debug] 	O1.class
[debug] 	T1$C.class
[debug] 	O1$.class
[debug] 	T1.class
[debug] Removing the temporary directory used for backing up class files: /Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes.bak
+ git co -f HEAD -- src/main/
+ exit
```