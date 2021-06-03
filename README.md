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
> ./build.sh
+ sbt compile
[info] welcome to sbt 1.5.3 (AdoptOpenJDK Java 1.8.0_272)
[info] loading global plugins from /Users/jz/.sbt/1.0/plugins
[info] loading project definition from /Users/jz/code/zinc-bug-implicit-in-package-object-parent/project
[info] loading settings for project zinc-bug-implicit-in-package-object-parent from build.sbt ...
[info] set current project to zinc-bug-implicit-in-package-object-parent (in build file:/Users/jz/code/zinc-bug-implicit-in-package-object-parent/)
[info] Executing in batch mode. For better performance use sbt's shell
[info] compiling 3 Scala sources to /Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes ...
[success] Total time: 4 s, completed 03/06/2021 10:55:40 PM
+ cp -R src/main-changes/scala src/main/
+ sbt debug compile
[info] welcome to sbt 1.5.3 (AdoptOpenJDK Java 1.8.0_272)
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
[debug] Getting org.scala-sbt:compiler-bridge_2.12:1.5.4:compile for Scala 2.12.14
[debug] [zinc] Running cached compiler 3d468f57 for Scala compiler version 2.12.14
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
[debug] Scala compilation took 2.456970134 s
[debug] done compiling
[debug] Registering generated classes:
[debug] 	O1$.class
[debug] 	O1.class
[debug] [inv] Invalidate package objects by inheritance only...
[debug] Initial set of included nodes: p1.T1.C
[debug] [inv] Package object invalidations:
[debug] About to delete class files:
[debug] 	T1$C.class
[debug] 	T1.class
[debug] We backup class files:
[debug] 	T1$C.class
[debug] 	T1.class
[debug] [inv] ********* Pruned:
[debug] [inv] Relations:
[debug] [inv]   products: Relation [
[debug] [inv]     ${BASE}/src/main/scala/p1/O1.scala -> ${BASE}/target/scala-2.12/classes/p1/O1$.class
[debug] [inv]     ${BASE}/src/main/scala/p1/O1.scala -> ${BASE}/target/scala-2.12/classes/p1/O1.class
[debug] [inv]     ${BASE}/src/main/scala/p1/package.scala -> ${BASE}/target/scala-2.12/classes/p1/package$.class
[debug] [inv]     ${BASE}/src/main/scala/p1/package.scala -> ${BASE}/target/scala-2.12/classes/p1/package.class
[debug] [inv] ]
[debug] [inv]   library deps: Relation [
[debug] [inv]     ${BASE}/src/main/scala/p1/O1.scala -> ${SBT_BOOT}/scala-2.12.14/lib/scala-library.jar
[debug] [inv] ]
[debug] [inv]   library class names: Relation [
[debug] [inv]     ${SBT_BOOT}/scala-2.12.14/lib/scala-library.jar -> scala.Int
[debug] [inv]     ${SBT_BOOT}/scala-2.12.14/lib/scala-library.jar -> scala.Unit
[debug] [inv] ]
[debug] [inv]   internalDependencies:
[debug] [inv]     DependencyByMemberRef Relation [
[debug] [inv]     p1.package -> p1.T1
[debug] [inv] ]
[debug] [inv]     DependencyByInheritance Relation [
[debug] [inv]     p1.package -> p1.T1
[debug] [inv] ]
[debug] [inv]   externalDependencies:
[debug] [inv]   class names: Relation [
[debug] [inv]     ${BASE}/src/main/scala/p1/O1.scala -> p1.O1
[debug] [inv]     ${BASE}/src/main/scala/p1/package.scala -> p1.package
[debug] [inv] ]
[debug] [inv]   used names: Relation [
[debug] [inv]     p1.O1 -> UsedName(AnyRef,[Default])
[debug] [inv]     p1.O1 -> UsedName(O1,[Default])
[debug] [inv]     p1.O1 -> UsedName(Object,[Default])
[debug] [inv]     p1.O1 -> UsedName(java;lang;Object;init;,[Default])
[debug] [inv]     p1.O1 -> UsedName(p1,[Default])
[debug] [inv]     p1.O1 -> UsedName(scala,[Default])
[debug] [inv]     p1.package -> UsedName(Object,[Default])
[debug] [inv]     p1.package -> UsedName(T1,[Default])
[debug] [inv]     p1.package -> UsedName(java;lang;Object;init;,[Default])
[debug] [inv]     p1.package -> UsedName(p1,[Default])
[debug] [inv]     p1.package -> UsedName(package,[Default])
[debug] [inv] ]
[debug] [inv]   product class names: Relation [
[debug] [inv]     p1.O1 -> p1.O1
[debug] [inv]     p1.O1 -> p1.O1$
[debug] [inv]     p1.package -> p1.package
[debug] [inv]     p1.package -> p1.package$
[debug] [inv] ]
[debug] [inv] *********
[debug] compilation cycle 2
[info] compiling 1 Scala source to /Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes ...
[debug] Getting org.scala-sbt:compiler-bridge_2.12:1.5.4:compile for Scala 2.12.14
[debug] [zinc] Running cached compiler 2c3056e1 for Scala compiler version 2.12.14
[debug] [zinc] The Scala compiler is invoked with:
[debug] 	-bootclasspath
[debug] 	/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/resources.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/rt.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/sunrsasign.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/jsse.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/jce.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/charsets.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/lib/jfr.jar:/Users/jz/.jabba/jdk/adopt@1.8.0-272/Contents/Home/jre/classes:/Users/jz/.sbt/boot/scala-2.12.14/lib/scala-library.jar
[debug] 	-classpath
[debug] 	/Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes
[error] Symbol 'type p1.T1' is missing from the classpath.
[error] This symbol is required by 'package p1.package'.
[error] Make sure that type T1 is in your classpath and check for conflicting dependencies with `-Ylog-classpath`.
[error] A full rebuild may help if 'package.class' was compiled against an incompatible version of p1.
[error] one error found
[debug] Compilation failed (CompilerInterface)
[debug] Rolling back changes to class files.
[debug] Removing generated classes:
[debug] 	O1.class
[debug] 	O1$.class
[debug] Restoring class files:
[debug] 	T1.class
[debug] 	T1$C.class
[debug] 	O1$.class
[debug] 	O1.class
[debug] Removing the temporary directory used for backing up class files: /Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes.bak
[error] (Compile / compileIncremental) Compilation failed
+ R=1
+ git co -f HEAD -- src/main/
+ exit 1
```

## Non-Zinc reproduction

```
> scalac --scala-version 2.12.14 -d /tmp -cp /tmp src/main/scala/p1/{O1,T1,package}.scala
> rm /tmp/p1/T1*.class
> scalac --scala-version 2.12.14 -d /tmp -cp /tmp src/main/scala/p1/T1.scala
error: Symbol 'type p1.T1' is missing from the classpath.
This symbol is required by 'package p1.package'.
Make sure that type T1 is in your classpath and check for conflicting dependencies with `-Ylog-classpath`.
A full rebuild may help if 'package.class' was compiled against an incompatible version of p1.
one error found
```

## Scalac Bug?

This is a limitation of `scalac`. It eagerly completes the info of `package.class` (see `openPackageModule`) on the
first reference to  that package (in this case the `package p1;` statement in the preamble of `T1.scala`.)

Zinc has deleted the  stale `T1.class` classfile prior to recompiling `T1.scala`, and the source symbol has not yet been named,
so the compiler assumes a classfile is missing.

It would certainly be great to find a way to make scalac a little lazier to make this work. It would help me fix
a tricky [compiler determism bug](https://github.com/scala/bug/issues/12092). 
I [tried this once](https://github.com/retronym/scala/pull/99) but haven't yet succeeded.

## Remediation in Zinc?

Interestingly, if `trait T1` is directly invalidated, Zinc invalidates `package.class` via inheritance, and works
around this issue, as shows by this [diff](https://github.com/retronym/zinc-bug-implicit-in-package-object-parent/pull/1/files)
to the source and Zinc log.

I notice there is already logic in Zinc to invalidate package objects. Perhaps this could be exended to deal with
the case when a package parent is not directly invalidated, but rather indirectly because a member class is
invalidated?

See:
  - https://github.com/sbt/zinc/blob/67afa3062985e1be1b3f3df89a14cd8f4f94f4e1/internal/zinc-core/src/main/scala/sbt/internal/inc/IncrementalCommon.scala#L81-L84
  - https://github.com/sbt/zinc/blob/67afa3062985e1be1b3f3df89a14cd8f4f94f4e1/internal/zinc-core/src/main/scala/sbt/internal/inc/IncrementalCommon.scala#L600-L616
  - https://github.com/sbt/zinc/blob/96a5e6f0fb61d7b35cf7cc964a8081d40ee88b70/internal/zinc-core/src/main/scala/sbt/internal/inc/IncrementalNameHashing.scala#L41-L52



