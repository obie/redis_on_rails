class TalksController < InheritedResources::Base
	expose(:events) { [] }
end
