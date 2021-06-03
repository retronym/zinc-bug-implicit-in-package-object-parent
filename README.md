## Incremental compilation bug in Zinc/SBT with package objects, inheritance, implicits, inferred types, oh my!

```
./build.sh
+ sbt compile
  [info] welcome to sbt 1.5.3 (AdoptOpenJDK Java 11.0.11)
  [info] loading global plugins from /Users/jz/.sbt/1.0/plugins
  [info] compiling 1 Scala source to /Users/jz/.sbt/1.0/plugins/target/scala-2.12/sbt-1.0/classes ...
  [info] loading project definition from /Users/jz/code/zinc-bug-implicit-in-package-object-parent/project
  [info] loading settings for project zinc-bug-implicit-in-package-object-parent from build.sbt ...
  [info] set current project to zinc-bug-implicit-in-package-object-parent (in build file:/Users/jz/code/zinc-bug-implicit-in-package-object-parent/)
  [info] Executing in batch mode. For better performance use sbt's shell
  [success] Total time: 0 s, completed 3 Jun. 2021, 5:07:07 pm
+ cp -R src/main-changes/scala src/main/
+ sbt debug compile
  [info] welcome to sbt 1.5.3 (AdoptOpenJDK Java 11.0.11)
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
  [debug] Initial set of included nodes: p1.O1
  [debug] About to delete class files:
  [debug] 	O1.class
  [debug] 	O1$.class
  [debug] We backup class files:
  [debug] 	O1.class
  [debug] 	O1$.class
  [debug] compilation cycle 1
  [info] compiling 1 Scala source to /Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes ...
  [debug] Getting org.scala-sbt:compiler-bridge_2.12:1.5.4:compile for Scala 2.12.14
  [debug] [zinc] Running cached compiler 67d35cd for Scala compiler version 2.12.14
  [debug] [zinc] The Scala compiler is invoked with:
  [debug] 	-bootclasspath
  [debug] 	/Users/jz/.sbt/boot/scala-2.12.14/lib/scala-library.jar
  [debug] 	-classpath
  [debug] 	/Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes
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
  [debug] Scala compilation took 1.990292866 s
  [debug] done compiling
  [debug] Registering generated classes:
  [debug] 	O1$.class
  [debug] 	O1.class
  [debug] Initial set of included nodes: p1.T1.C
  [debug] About to delete class files:
  [debug] 	T1$C.class
  [debug] 	T1.class
  [debug] We backup class files:
  [debug] 	T1$C.class
  [debug] 	T1.class
  [debug] compilation cycle 2
  [info] compiling 1 Scala source to /Users/jz/code/zinc-bug-implicit-in-package-object-parent/target/scala-2.12/classes ...
  [debug] Getting org.scala-sbt:compiler-bridge_2.12:1.5.4:compile for Scala 2.12.14
  [debug] [zinc] Running cached compiler 38af8e0e for Scala compiler version 2.12.14
  [debug] [zinc] The Scala compiler is invoked with:
  [debug] 	-bootclasspath
  [debug] 	/Users/jz/.sbt/boot/scala-2.12.14/lib/scala-library.jar
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
```