import PerfectLib
import PerfectHTTPServer
import PerfectHTTP


let server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "webroot"

let sleepRoutine = SleepRoutine()

var routes = Routes()


routes.add(method: .get, uri: "/{sleepschedule}/{ledlevel}/{wakeup}/{sleep}", handler: { request, response in
    let reqVar = request.urlVariables
    guard let sleepSchedule = reqVar["sleepschedule"], let ledLevel = reqVar["ledlevel"], let wakeUp = reqVar["wakeup"], let sleep = reqVar["sleep"] else {
        response.completed(status: .badRequest)
        return
    }
    sleepRoutine.sleepSchedule = sleepSchedule
    sleepRoutine.ledLevel = Int(ledLevel) ?? 0
    sleepRoutine.wakeUp = Bool(wakeUp) ?? false
    sleepRoutine.sleepNoti = Bool(sleep) ?? false
    
    response.completed()
   
   
})

routes.add(method: .get, uri: "/node", handler: {
    request, response in
    let wakeUp = sleepRoutine.wakeUp
    let sleep = sleepRoutine.sleepNoti
    let ledLevel = sleepRoutine.ledLevel
    let dic = ["wakeUp": wakeUp, "sleep": sleep, "ledLevel": ledLevel] as [String : Any]
    do {
        try response.setBody(json: dic)
        .completed()
    } catch {
        response.completed(status: .internalServerError)
    }
})

server.addRoutes(routes)

do {
    try server.start()
} catch PerfectError.networkError(let error, let message){
    print("network error : \(error) \(message)")
}
