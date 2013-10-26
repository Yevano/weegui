--@import weegui.graphics.DrawContext

--@import see.rt.UnsupportedOperationException
--@import see.io.Terminal

--@extends weegui.graphics.DrawContext

function MonitorDrawContext:init()
    DrawContext.init(self)
end

function MonitorDrawContext:getSize()
    return Terminal.getSize()
end

function MonitorDrawContext:setPixel(x, y)
	Terminal.setPos(x, y)
    Terminal.setFG(self.fg)
    Terminal.setBG(self.bg)
    Terminal.write(self.char)
end

function MonitorDrawContext:getPixel()
    throw(UnsupportedOperationException.new("Cannot retrieve pixel data from monitor."))
end