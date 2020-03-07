import Foundation
import UIKit

public class WorldView: UIView {
    
    var world: World = World(size: 100)
    var cellSize: Int = 10
    
    public convenience init(worldSize: Int, cellSize: Int) {
        let size = worldSize * cellSize
        let frame = CGRect(x: 0, y: 0, width: size, height: size)
        self.init(frame: frame)
        self.world = World(size: worldSize)
        self.cellSize = cellSize
    }
    
    public convenience init() {
        let frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        self.init(frame: frame)
    }
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        for cell in world.cells {
            let x = cell.x * cellSize
            let y = cell.y * cellSize
            
            let rect = CGRect(x: x, y: y, width: cellSize, height: cellSize)
            
            var color = UIColor.white.cgColor
            if cell.state == .alive {
                color = UIColor.green.cgColor
            }
            
            context?.addRect(rect)
            context?.setFillColor(color)
            context?.fill(rect)
        }
        context?.restoreGState()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        world.updateCells()
        setNeedsDisplay()
    }
    
    public func autoRun() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.world.updateCells()
            self.setNeedsDisplay()
            self.autoRun()
        }
    }
}
