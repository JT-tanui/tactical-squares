import { Link, useLocation } from "react-router-dom";
import { Target, BookOpen, Play, User } from "lucide-react";

const Navigation = () => {
  const location = useLocation();

  return (
    <nav className="fixed top-0 left-0 w-full bg-chess-primary p-4 shadow-md z-50">
      <div className="container mx-auto">
        <div className="flex items-center justify-between">
          {/* Logo/Brand */}
          <Link to="/" className="flex items-center gap-2">
            <Target className="w-6 h-6 text-chess-accent" />
            <span className="text-xl font-bold text-chess-light hidden md:inline">Chess AI Coach</span>
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden md:flex items-center gap-8">
            <NavItem to="/" icon={<Target />} label="Home" active={location.pathname === "/"} />
            <NavItem to="/learn" icon={<BookOpen />} label="Learn" active={location.pathname === "/learn"} />
            <NavItem to="/practice" icon={<Target />} label="Practice" active={location.pathname === "/practice"} />
            <NavItem to="/play" icon={<Play />} label="Play" active={location.pathname === "/play"} />
            <NavItem to="/profile" icon={<User />} label="Profile" active={location.pathname === "/profile"} />
          </div>

          {/* Mobile Navigation */}
          <div className="flex md:hidden justify-around fixed bottom-0 left-0 w-full bg-chess-primary p-4 gap-4">
            <NavItem to="/" icon={<Target />} label="Home" active={location.pathname === "/"} />
            <NavItem to="/learn" icon={<BookOpen />} label="Learn" active={location.pathname === "/learn"} />
            <NavItem to="/practice" icon={<Target />} label="Practice" active={location.pathname === "/practice"} />
            <NavItem to="/play" icon={<Play />} label="Play" active={location.pathname === "/play"} />
            <NavItem to="/profile" icon={<User />} label="Profile" active={location.pathname === "/profile"} />
          </div>
        </div>
      </div>
    </nav>
  );
};

const NavItem = ({ to, icon, label, active }: { to: string; icon: React.ReactNode; label: string; active: boolean }) => (
  <Link
    to={to}
    className={`flex items-center gap-2 px-3 py-2 rounded-md transition-colors duration-200 ${
      active
        ? "text-chess-accent bg-chess-primary/50"
        : "text-chess-light hover:text-chess-accent hover:bg-chess-primary/30"
    }`}
  >
    <span className="text-xl">{icon}</span>
    <span className="text-sm font-medium">{label}</span>
  </Link>
);

export default Navigation;