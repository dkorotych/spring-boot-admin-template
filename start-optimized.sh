#!/bin/bash

# Optimized startup script for Spring Boot Admin
# This script includes JVM performance optimizations

# Set JVM options for optimal performance
export JAVA_OPTS="-server \
-XX:+UseG1GC \
-XX:MaxGCPauseMillis=200 \
-XX:+UseStringDeduplication \
-XX:+OptimizeStringConcat \
-XX:+UseCompressedOops \
-XX:+UseCompressedClassPointers \
-XX:+TieredCompilation \
-XX:TieredStopAtLevel=1 \
-XX:+UseFastUnorderedTimeStamps \
-XX:+UseAES \
-XX:+UseAESIntrinsics \
-XX:+UseFMA \
-XX:+UseSHA \
-XX:+UseSHA1Intrinsics \
-XX:+UseSHA256Intrinsics \
-XX:+UseSHA512Intrinsics \
-XX:+UseCRC32Intrinsics \
-XX:+UseCRC32CIntrinsics \
-XX:+UseAdler32Intrinsics \
-XX:+UseVectorizedMismatchIntrinsics \
-XX:+UseVectorizedHashCodeIntrinsics \
-XX:+UsePopCountInstruction \
-XX:+UseCountLeadingZerosInstruction \
-XX:+UseCountTrailingZerosInstruction \
-XX:+UseBitManipulationInstructions \
-XX:+UseVectorizedMismatchIntrinsics \
-XX:+UseVectorizedHashCodeIntrinsics \
-XX:+UsePopCountInstruction \
-XX:+UseCountLeadingZerosInstruction \
-XX:+UseCountTrailingZerosInstruction \
-XX:+UseBitManipulationInstructions \
-Djava.security.egd=file:/dev/./urandom \
-Dspring.jmx.enabled=false \
-Dspring.backgroundpreinitializer.ignore=true \
-Dspring.main.lazy-initialization=true \
-Dspring.jpa.open-in-view=false \
-Dspring.devtools.restart.enabled=false \
-Dspring.devtools.livereload.enabled=false \
-Dspring.thymeleaf.cache=true \
-Dserver.compression.enabled=true \
-Dserver.http2.enabled=true"

# Memory settings (adjust based on available memory)
export HEAP_SIZE="512m"
export MAX_HEAP_SIZE="1g"
export NEW_SIZE="256m"
export MAX_NEW_SIZE="512m"

# Additional JVM options for memory optimization
export MEMORY_OPTS="-Xms${HEAP_SIZE} -Xmx${MAX_HEAP_SIZE} -Xmn${NEW_SIZE} -XX:MaxNewSize=${MAX_NEW_SIZE}"

# Combine all options
export FINAL_JAVA_OPTS="${JAVA_OPTS} ${MEMORY_OPTS}"

echo "Starting Spring Boot Admin with optimized JVM settings..."
echo "JVM Options: ${FINAL_JAVA_OPTS}"

# Start the application
java ${FINAL_JAVA_OPTS} -jar admin-console.jar