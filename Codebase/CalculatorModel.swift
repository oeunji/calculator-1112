import Foundation

class CalculatorModel {
    private var expression: String = ""
    
    // 식에 항목 추가
    func append(_ value: String) {
        expression += value
    }
    
    // 계산 수행
    func calculate() -> String? {
        // ×, ÷, −를 *, /, -로 변환하여 NSExpression에서 사용할 수 있게 처리
        let exp = expression.replacingOccurrences(of: "×", with: "*")
                               .replacingOccurrences(of: "÷", with: "/")
                               .replacingOccurrences(of: "−", with: "-")
        
        let nsExpression = NSExpression(format: exp)
        if let result = nsExpression.expressionValue(with: nil, context: nil) as? NSNumber {
            expression = ""  // 계산 후 식 초기화
            return result.stringValue
        } else {
            expression = ""  // 계산 후 식 초기화
            return nil
        }
    }
    
    // 식 초기화
    func clear() {
        expression = ""
    }
    
    // 현재 식을 반환
    func getExpression() -> String {
        return expression
    }
}
