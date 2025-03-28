val itineraries = sc.textFile("C:/Users/mjako/OneDrive/Desktop/CI2.CSV")

val startTime = System.nanoTime()

val parsedData = itineraries.map(line => {
  val cols = line.split(",")
  
  if (cols.length > 14) {
    val airline = cols(21)
    val isBasicEconomy = cols(8)
    val seatsRemaining = try {
      cols(13).toInt
    } catch {
      case e: NumberFormatException => 0 
    }
    val totalFare = try {
      cols(12).toDouble
    } catch {
      case e: NumberFormatException => -1.0 
    }
    
    val totalTravelDistance = try {
      cols(14).toDouble
    } catch {
      case e: NumberFormatException => -1.0 
    }
    
    if (totalFare > 0 && totalTravelDistance > 0) {
      val seatsLeft = if (seatsRemaining <= 5) "<= 5 seats left" else "> 5 seats left"
      
      ((airline, isBasicEconomy, seatsLeft), (totalFare / totalTravelDistance, 1))
    } else {
      (("invalid", "invalid", "invalid"), (0.0, 0))
    }
  } else {
    (("invalid", "invalid", "invalid"), (0.0, 0))
  }
}).filter {
  case (key, value) => key != ("invalid", "invalid", "invalid")
}

val aggregatedData = parsedData.reduceByKey((a, b) => (a._1 + b._1, a._2 + b._2))

val finalData = aggregatedData.mapValues(v => v._1 / v._2)

val sortedData = finalData.sortBy(_._2)

sortedData.collect().foreach(println)

val endTime = System.nanoTime()
val duration = (endTime - startTime) / 1e9d  
println(s"Execution time: $duration seconds")
